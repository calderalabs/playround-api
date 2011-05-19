class Arena < ActiveRecord::Base
  has_many :rounds

  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude
  
  validates_length_of :name, :in => 3..30
  
  validates_numericality_of :latitude, :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90
  validates_numericality_of :longitude, :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180
  
  validates_url_format_of :website, :allow_blank => true
  adjusts_string :website, :prepend => 'http://', :if => Proc.new { |a| !(a.website =~ /^.*:.*$/) }
end
