class Round < ActiveRecord::Base
  has_many :subscriptions

  after_initialize :initialize_default_values

  belongs_to :arena
  belongs_to :game
  belongs_to :user
  
  validate do
    errors.add(:deadline, "must be earlier than date") if self.deadline && self.date && self.deadline > self.date
    
    errors.add(:deadline, "must be after the current time") if self.deadline && self.deadline < Time.now.change(:sec => 0)
    errors.add(:date, "must be after the current time") if self.date && self.date < Time.now.change(:sec => 0)
  end
  
  validates_presence_of :name
  validates_presence_of :deadline
  validates_presence_of :date
  validates_presence_of :max_people
  validates_presence_of :min_people
  validates_presence_of :arena_id
  validates_presence_of :game_id
  validates_presence_of :user_id
  
  validates_numericality_of :max_people, :greater_than_or_equal_to => :min_people, :greater_than => 0, :only_integer => true, :unless => Proc.new { |round| round.min_people.nil? }
  validates_numericality_of :min_people, :greater_than => 0, :only_integer => true
  
  validates_length_of :name, :in => 3..30
  
  adjusts_string :name, :case => :capitalize
  
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
  
  def full?
    self.remaining_spots == 0
  end
  
  def remaining_spots
    self.max_people - self.subscriptions.count
  end
  
  def authorized?(user)
    self.user == user
  end

  private
  
  def initialize_default_values
    self.date ||= Time.now
    self.deadline ||= Time.now
  end
end
