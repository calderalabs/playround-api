class Round < ActiveRecord::Base
  after_initialize :initialize_default_values
  before_save :capitalize_name
  
  belongs_to :arena
  
  validate :validate_deadline_should_be_earlier_than_or_equal_to_date
  
  validates_presence_of :name
  validates_presence_of :deadline
  validates_presence_of :date
  validates_presence_of :max_people
  validates_presence_of :min_people
  validates_presence_of :arena_id
  
  validates_numericality_of :max_people, :greater_than_or_equal_to => :min_people, :greater_than => 0, :only_integer => true
  validates_numericality_of :min_people, :greater_than => 0, :only_integer => true
  
  validates_length_of :name, :in => 3..30
  
  private
  
  def initialize_default_values
    self.date ||= Time.now
    self.deadline ||= Time.now
  end
  
  def validate_deadline_should_be_earlier_than_or_equal_to_date
    errors.add(:deadline, "should be earlier than date") if self.deadline > self.date
  end
  
  def capitalize_name
    self.name.capitalize!
  end
end
