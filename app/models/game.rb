class Game < ActiveRecord::Base
  has_many :rounds
  belongs_to :user
  
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :user_id
  
  validates_length_of :name, :maximum => 30
  
  validates_url_format_of :website, :allow_blank => true
  adjusts_string :website, :prepend => 'http://', :if => Proc.new { |a| !(a.website =~ /^.*:.*$/) }
  adjusts_string :name, :case => :capitalize
end
