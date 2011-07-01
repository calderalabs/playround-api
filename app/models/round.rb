class Round < ActiveRecord::Base
  attr_accessible :deadline, :date, :max_people, :min_people, :arena_id, :game_id, :description
  
  after_initialize :initialize_default_values

  belongs_to :arena
  geocoded_through :arena
  belongs_to :game
  belongs_to :user
  has_many :subscriptions
  has_many :comments
  has_many :subscribers, :through => :subscriptions, :source => :user
  
  before_validation :validate_date_deadline if !@recently_confirmed
  
  def validate_date_deadline
    errors.add(:deadline, "must be earlier than date") if self.deadline && self.date && self.deadline > self.date
    
    errors.add(:deadline, "must be after the current time") if self.deadline && self.deadline < Time.now.change(:sec => 0)
    errors.add(:date, "must be after the current time") if self.date && self.date < Time.now.change(:sec => 0)
  end
  
  validates_presence_of :deadline
  validates_presence_of :date
  validates_presence_of :max_people
  validates_presence_of :min_people
  validates_presence_of :arena_id
  validates_presence_of :game_id
  validates_presence_of :user_id
  
  validates_numericality_of :max_people, :greater_than_or_equal_to => :min_people, :greater_than => 1, :only_integer => true, :unless => Proc.new { |round| round.min_people.nil? }
  validates_numericality_of :min_people, :greater_than => 1, :only_integer => true
  
  validate do
    self.errors.add(:base, "You cannot confirm this round") if @recently_confirmed && !self.confirmable?
  end
  
  def date=(date)
    if date
      super(date.change(:sec => 0))
    else
      super(nil)
    end
  end
  
  def deadline=(deadline)
    if deadline
      super(deadline.change(:sec => 0))
    else
      super(nil)
    end
  end
  
  def all_subscribers
    self.subscribers + [self.user]
  end
  
  def remaining_spots
    self.max_people - self.all_subscribers.count
  end
  
  def full?
    self.remaining_spots == 0
  end
  
  def authorized?(user)
    self.user == user
  end

  def confirmable?
    !self.confirmed_was && Time.now > self.deadline && Time.now < self.date
  end
  
  def confirmed=(confirmed)
    @recently_confirmed = confirmed

    super(confirmed)
  end
  
  def confirm!
    self.confirmed = true
    self.save
  end

  after_save do
    self.subscribers.each do |user|
      RoundMailer.round_confirmation_email(self, user).deliver
    end if @recently_confirmed
  end

  private
  
  def initialize_default_values
    self.date ||= Time.now
    self.deadline ||= Time.now
  end
end
