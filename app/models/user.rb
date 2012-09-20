class User < ActiveRecord::Base
  include Clearance::User
  
  acts_as_taggable_on :interests
  
  attr_accessible :display_name, :real_name, :email, :password, :avatar, :town_woeid, :show_email, :language

  has_attached_file :avatar, { :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                               :default_url => '/images/missing_avatar.gif' }.merge(PAPERCLIP_CONFIG)
  
  before_validation do
    self.display_name ||= self.email.split('@').first
  end
  
  has_many :subscriptions
  has_many :rounds
  has_many :arenas
  has_many :comments
  has_many :games
  has_one :quicktour
  
  validates_presence_of :display_name
  validates_length_of :real_name, :in => 3..30, :allow_blank => true
  
  def shows_quicktour?
    !!self.quicktour
  end
  
  def subscribed?(round)
    self.subscriptions.exists?(:round_id => round.id)
  end
  
  def guest?
    self.new_record?
  end
end
