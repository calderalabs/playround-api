class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :subscriptions

  def subscribed?(round)
    self.subscriptions.exists?(:round_id => round.id)
  end
end
