class Round < ActiveRecord::Base 
  attr_accessible :date, :people, :arena_id, :game_id, :description

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
    errors.add(:arena_id, "must be a public arena or a private arena that you own") if arena && !arena.public? && arena.user != user
  end
  
  validate :on => :update do
    editable_attributes = [:description, :approved, :confirmed]

    errors.add(:base, "You cannot approve or reject this round") if approved_changed? && !approvable?
    errors.add(:base, "You cannot confirm this round") if confirmed_changed? && !confirmable?
    
    changed_attributes.each do |attribute, value|
      errors.add(attribute.to_sym, "cannot be changed after creation") if !editable_attributes.include?(attribute.to_sym)
    end
  end
  
  before_validation :on => :create do
    self.approved = true if user == arena.user
  end
  
  before_destroy do
    errors.add(:base, "You can't delete a round with subscribers") and return false unless destroyable?
  end
  
  after_save do
    subscribers.each do |user|
      RoundMailer.confirmation_email(self, user).deliver
    end if @recently_confirmed
  end
  
  validates_presence_of :date
  validates_presence_of :people
  validates_presence_of :arena_id
  validates_presence_of :game_id
  validates_presence_of :user_id
  
  validates_numericality_of :people, :only_integer => true, :greater_than_or_equal_to => 2
  
  scope :pending_approval, lambda {
    where("approved = ?", false)
  }
  
  scope :approved, lambda {
    where("approved = ?", true)
  }
  
  def date=(date)
    super(date.try(:change, :sec => 0))
  end
  
  def deadline=(deadline)
    super(deadline.try(:change, :sec => 0))
  end
  
  def confirmed=(confirmed)
    @recently_confirmed = confirmed
    
    super(confirmed)
  end
  
  def remaining_spots
    people - subscriptions.length
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
  
  def approvable?
    !approved_was && !past?
  end
  
  def approve!
    self.approved = true
    save
  end
  
  def reject!
    self.approved = false
    save
  end
  
  def confirmable?
    approved && !confirmed_was && !past? && full? 
  end
  
  def confirm!
    self.confirmed = true
    save
  end
end
