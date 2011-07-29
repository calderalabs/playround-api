class Subscription < ActiveRecord::Base
  attr_accessible :round_id
  
  belongs_to :user
  belongs_to :round
  
  validates_presence_of :user_id
  validates_presence_of :round_id
  validates_uniqueness_of :round_id, :scope => :user_id
  
  before_destroy do
    errors.add(:base, t('activerecord.errors.subscription.unsubscribe.failure')) and return false unless destroyable?
  end
  
  validate do
    errors.add(:base, t('activerecord.errors.subscription.subscribe.failure')) unless round && round.approved? && !round.past? && !round.full?
  end
  
  def destroyable?
    round && !round.past? && !round.confirmed?
  end
end
