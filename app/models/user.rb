class User < ActiveRecord::Base
  include Clearance::User
  
  has_many :subscriptions
  has_many :rounds
  has_many :games
  has_many :arenas

  def subscribed?(round)
    self.subscriptions.exists?(:round_id => round.id)
  end
end
