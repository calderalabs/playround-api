class User < ActiveRecord::Base
  include Clearance::User
  
  attr_accessible :display_name, :real_name, :email, :password, :avatar, :town_woeid, :show_email
  attr_accessor :show_email, :show_quicktour, :current_guider
  
  has_attached_file :avatar, { :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                               :default_url => '/images/missing_avatar.gif' }.merge(PAPERCLIP_CONFIG)
  
  before_validation do
    self.display_name ||= self.email.split('@').first
  end
  
  after_initialize do
    self.show_quicktour ||= true
    self.current_guider ||= 'welcome'
    self.show_email ||= false
  end
  
  after_find do
    self.show_quicktour = settings[:show_quicktour]
    self.current_guider = settings[:current_guider]
    self.show_email = settings[:show_email]
  end
  
  after_save do
    self.settings[:show_quicktour] = show_quicktour
    self.settings[:current_guider] = current_guider
    self.settings[:show_email] = show_email
  end
  
  has_many :subscriptions
  has_many :rounds
  has_many :arenas
  has_many :comments
  has_many :games
  
  validates_presence_of :display_name
  validates_length_of :real_name, :in => 3..30, :allow_blank => true
  
  def subscribed?(round)
    self.subscriptions.exists?(:round_id => round.id)
  end
  
  def guest?
    new_record?
  end
  
  def shows_email?
    !!show_email
  end
  
  def shows_quicktour?
    !!show_quicktour
  end
end
