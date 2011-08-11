class Vote < ActiveRecord::Base

  named_scope :for_voter,    lambda { |*args| {:conditions => ["voter_id = ? AND voter_type = ?", args.first.id, args.first.type.name]} }
  named_scope :for_voteable, lambda { |*args| {:conditions => ["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.type.name]} }
  named_scope :recent,       lambda { |*args| {:conditions => ["created_at > ?", (args.first || 2.weeks.ago).to_s(:db)]} }
  named_scope :descending, :order => "created_at DESC"

  # NOTE: Votes belong to the "voteable" interface, and also to voters
  belongs_to :voteable, :polymorphic => true
  belongs_to :voter,    :polymorphic => true
  
  attr_accessible :vote, :voter, :voteable
  
  validate :validate_subscriber, :if => Proc.new { |v| v.voteable_type == "Subscription" }
  after_save :declare_winner, :if => Proc.new { |v| v.voteable_type == "Subscription" }
  
  def validate_subscriber
    @round = Round.find(Subscription.find(self.voteable_id).round_id)
    errors.add(:base, "You cannot vote the winner for this round") unless @round.subscribers.collect{ |s| s.id }.include?(self.voter_id) || @round.won?
  end
  
  def declare_winner
    @winner, @winner_votes, @votes = 0
    @round = Round.find(Subscription.find(self.voteable_id).round_id)
    @round.subscriptions.each do |s|
      if s.votes_count > @winner_votes 
        @winner = s.user_id
        @winner_votes = s.votes_count
      end
      @votes += s.votes_count
    end
    
    if @votes >= @round.people / 2
      @round.winner_id = @winner
      @round.save
    end
  end

  # Uncomment this to limit users to a single vote on each item. 
  validates_uniqueness_of :voteable_id, :scope => [:voteable_type, :voter_type, :voter_id]

end