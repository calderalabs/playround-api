class Game < ActiveRecord::Base
  attr_accessible :name, :description, :website
  
  has_many :rounds
  
  validates_presence_of :name
  validates_presence_of :description
  
  validates_length_of :name, :maximum => 30
  
  validates_url_format_of :website, :allow_blank => true
  adjusts_string :website, :prepend => 'http://', :if => Proc.new { |a| !(a.website =~ /^.*:.*$/) }
end
