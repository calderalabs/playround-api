class Quicktour < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :user_id
  
  GUIDERS = %w(welcome location profile rounds arenas)
  
  def next!
    self.current_guider += 1
    self.save
  end
  
  validates_numericality_of :current_guider, :less_than => Proc.new { GUIDERS.count }, :greater_than_or_equal_to => 0, :only_integer => true
end
