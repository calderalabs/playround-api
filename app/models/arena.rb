class Arena < ActiveRecord::Base
  before_validation :adjust_website_url

  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude
  
  validates_length_of :name, :in => 3..30
  
  validates_numericality_of :latitude, :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90
  validates_numericality_of :longitude, :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180
  
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true
  
  def adjust_website_url
   unless self.website.blank?
     self.website = 'http://' + self.website unless self.website =~ /^.*:.*$/ # Prepend the default schema (http) if it was not present already
   end
  end
end
