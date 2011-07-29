class Round < ActiveRecord::Base 
  attr_accessible :date, :people, :arena_id, :game_id, :description
  attr_editable :state, :description
  
  after_initialize do
    self.date ||= Time.now
  end

  belongs_to :arena
  belongs_to :game
  belongs_to :user
  has_many :subscriptions
  has_many :comments
  has_many :subscribers, :through => :subscriptions, :source => :user
  
  validate :on => :create do
    errors.add(:date, "must be after the current time") if date && date < Time.now.change(:sec => 0)
    errors.add(:arena_id, "must be a public arena or a private arena that you own") unless arena && (arena.public? || owned_by_arena?)
  end
  
  before_validation :on => :create do
    approve if owned_by_arena? && pending?
  end
  
  before_destroy do
    errors.add(:base, "You can't delete a round with subscribers") and return false unless destroyable?
  end
  
  validates_presence_of :date
  validates_presence_of :people
  validates_presence_of :arena_id
  validates_presence_of :game_id
  validates_presence_of :user_id
  
  validates_numericality_of :people, :only_integer => true, :greater_than_or_equal_to => 2
  
  state_machine :initial => :pending do
    state :pending
    state :rejected
    state :approved
    state :confirmed
    
    event :approve do
      transition [:pending, :rejected] => :approved, :if => lambda { |round| !round.past? }
    end
    
    event :reject do
      transition [:pending, :approved] => :rejected, :if => lambda { |round| !round.past? }
    end

    event :confirm do
      transition :approved => :confirmed, :if => lambda { |round| !round.past? && round.full? }
    end
    
    after_transition :on => :confirm, :do => :notify_subscribers!
  end
  
  scope :pending, lambda {
    where(:state => :pending)
  }
  
  scope :approved, lambda {
    where(:state => :approved)
  }
  
  scope :rejected, lambda {
    where(:state => :rejected)
  }
  
  def date=(date)
    super(date.try(:change, :sec => 0))
  end
  
  def deadline=(deadline)
    super(deadline.try(:change, :sec => 0))
  end
  
  def remaining_spots
    people - subscriptions.length
  end
  
  def owned_by_arena?
    user && user == arena.user
  end
  
  def destroyable?
    subscriptions.count == 0
  end
  
  def full?
    remaining_spots == 0
  end

  def past?
    Time.now > date
  end
  
  def subscription_for(user)
    subscriptions.where(:user_id => user.id).first
  end
  
  def subscribable_by?(user)
    subscription = Subscription.new(:round_id => id)
    subscription.user = user
    subscription.valid?
  end
  
  def unsubscribable_by?(user)
    !!subscription_for(user).try(:destroyable?)
  end
  
  private
  
  def notify_subscribers!
    subscribers.each do |user|
      RoundMailer.confirmation_email(self, user).deliver
    end
  end
end
