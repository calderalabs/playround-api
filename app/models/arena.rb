class Arena < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :website, :public, :description, :image, :town_woeid, :address

  has_many :rounds
  belongs_to :user
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => '/images/missing_arena_:style.png',
                    :storage => :s3, :s3_credentials => 'config/s3.yml'

  validates_presence_of :name
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :user_id
  validates_presence_of :address
  
  validates_length_of :name, :in => 3..30
  
  validates_numericality_of :latitude, :greater_than_or_equal_to => -90, :less_than_or_equal_to => 90
  validates_numericality_of :longitude, :greater_than_or_equal_to => -180, :less_than_or_equal_to => 180
  
  before_validation do
    address = Geocoder.search([self.latitude, self.longitude]).try(:first).try(:address)
    location = GeoPlanet::Place.search(address.to_s).try(:first)
    
    town = location if location.try(:placetype_code) == 7
    town ||= location.try(:belongtos, { :type => 7 }).try(:first)
    
    self.town_woeid = town.try(:woeid)
    
    errors.add(:address, "must be in a town or city") unless self.town_woeid
  end
  
  validates_url_format_of :website, :allow_blank => true
  adjusts_string :website, :prepend => 'http://', :if => Proc.new { |a| !(a.website =~ /^.*:.*$/) }
  
  reverse_geocoded_by :latitude, :longitude
end
