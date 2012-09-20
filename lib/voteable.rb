module Voteable
  def self.included(base)
    base.has_many :votes, :as => :voteable, :dependent => :destroy
  end

  def self.classes
    [Subscription]
  end

  def voted_by?(user)
    !!vote_for_user(user)
  end

  def upvoted_by?(user)
    !!votes.where(:user_id => user.id, :rate => 1).first
  end

  def downvoted_by?(user)
    !!votes.where(:user_id => user.id, :rate => -1).first
  end

  def voter_ids
    votes.map(&:user_id)
  end

  def vote_for_user(user)
    votes.where(:user_id => user.id).first
  end

  def vote_with_user(user)
    Vote.new do |vote|
      vote.user = user
      vote.voteable = self
    end
  end

  def vote_for_or_with_user(user)
    vote_for_user(user) || vote_with_user(user)
  end
end