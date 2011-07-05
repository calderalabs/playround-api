class Subscription < ActiveRecord::Base
  attr_accessible :round_id
  
  belongs_to :user
  belongs_to :round
  
  validates_presence_of :user_id
  validates_presence_of :round_id
  validates_uniqueness_of :round_id, :scope => :user_id, :message => "- this subscription has already been created"
  
  validate do
    errors.add(:base, "You cannot subscribe to this round") if !self.round.subscribable?
  end
end
