class Game < ActiveRecord::Base
  attr_accessible :name, :description, :website, :image
  
  belongs_to :user
  has_many :rounds
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => '/images/black-king.png'
  
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :user
  
  validates_length_of :name, :maximum => 30
  
  validates_url_format_of :website, :allow_blank => true
  adjusts_string :website, :prepend => 'http://', :if => Proc.new { |a| !(a.website =~ /^.*:.*$/) }
end
