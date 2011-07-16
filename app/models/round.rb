class Round < ActiveRecord::Base
  attr_accessible :deadline, :date, :max_people, :min_people, :arena_id, :game_id, :description
  
  after_initialize :initialize_default_values

  belongs_to :arena
  belongs_to :game
  belongs_to :user
  has_many :subscriptions
  has_many :comments
  has_many :subscribers, :through => :subscriptions, :source => :user
  
  before_validation :validate_date_deadline, :if => Proc.new { !@recently_confirmed }
  
  def validate_date_deadline
    errors.add(:deadline, "must be earlier than date") if self.deadline && self.date && self.deadline > self.date
    
    errors.add(:deadline, "must be after the current time") if self.deadline && self.deadline < Time.now.change(:sec => 0)
    errors.add(:date, "must be after the current time") if self.date && self.date < Time.now.change(:sec => 0)
  end
  
  before_validation do
    errors.add(:arena_id, "must be a public arena or a private arena that you own") if self.arena && !self.arena.public? && self.arena.user_id != self.user_id
  end
  
  validate do
    self.errors.add(:base, "You cannot confirm this round") if @recently_confirmed && !self.confirmable?
  end
  
  after_save do
    subscribers.each do |user|
      RoundMailer.round_confirmation_email(self, user).deliver
    end if @recently_confirmed
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
  
  def date=(date)
    super(date.try(:change, :sec => 0))
  end
  
  def deadline=(deadline)
    super(deadline.try(:change, :sec => 0))
  end
  
  def subscribers_and_owner
    subscribers + [user]
  end
  
  def remaining_spots
    max_people - subscribers_and_owner.count
  end
  
  def full?
    remaining_spots == 0
  end
  
  def authorized?(some_user)
    user == some_user
  end

  def past?
    Time.now > date
  end
  
  def past_deadline?
    Time.now > deadline
  end

  def confirmable?
    !confirmed_was && past_deadline? && !past?
  end
  
  def confirmed=(confirmed)
    @recently_confirmed = confirmed

    super(confirmed)
  end
  
  def confirm!
    self.confirmed = true
    save
  end
  
  def subscribable?
    !past_deadline? && !full?
  end

  private
  
  def initialize_default_values
    self.date ||= Time.now
    self.deadline ||= Time.now
  end
end
