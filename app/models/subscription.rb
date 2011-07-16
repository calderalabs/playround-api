class Subscription < ActiveRecord::Base
  attr_accessible :round_id
  
  belongs_to :user
  belongs_to :round
  
  validates_presence_of :user_id
  validates_presence_of :round_id
  validates_uniqueness_of :round_id, :scope => :user_id
  
  validate do
    errors.add(:base, "You cannot subscribe to this round") if round && !round.subscribable?
  end
end
