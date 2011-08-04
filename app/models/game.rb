class Game < ActiveRecord::Base
  attr_accessible :name, :description, :website, :image
  
  belongs_to :user
  has_many :rounds
  
  has_attached_file :image, { :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
                              :default_url => '/images/missing_game_:style.png' }.merge(PAPERCLIP_CONFIG)
  
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :user_id
  
  validates_length_of :name, :maximum => 30
  
  before_destroy do
    errors.add(:base, I18n.t('activerecord.errors.game.delete_with_rounds')) and return false unless rounds.count == 0
  end
  
  validates_url_format_of :website, :allow_blank => true
  adjusts_string :website, :prepend => 'http://', :if => Proc.new { |a| !(a.website =~ /^.*:.*$/) }
end
