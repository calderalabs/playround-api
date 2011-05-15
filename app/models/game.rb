class Game < ActiveRecord::Base
  before_save :capitalize_name
  before_validation :adjust_website_url

  validates_presence_of :name
  validates_presence_of :description
  
  validates_length_of :name, :maximum => 30
  
  validates_format_of :website, :with => /^(#{URI::regexp(%w(http https))})$/, :allow_blank => true

  def capitalize_name
    self.name.capitalize!
  end
  
  def adjust_website_url
   unless self.website.blank?
     self.website = 'http://' + self.website unless self.website =~ /^.*:.*$/ # Prepend the default schema (http) if it was not present already
   end
  end
end
