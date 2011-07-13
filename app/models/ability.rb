class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :create, User if user.guest?
    
    can :read, [Arena, Comment, Round, Game, User]
    
    can :create, [Round, Arena, Comment, Game] unless user.guest?
    
    can :update, [Arena, Comment, Game], :user_id => user.id
    
    can :update, Round do |round|
      round.user_id == user.id && Time.now < round.deadline
    end
    
    can :update, User, :id => user.id
    
    can :destroy, Comment, :user_id => user.id
    
    can :destroy, Round do |round|
      round.subscribers.count == 0 && round.user_id == user.id
    end
    
    can :destroy, Arena do |arena|
      arena.rounds.count == 0 && arena.user_id == user.id
    end
    
    can :destroy, Game do |game|
      game.rounds.count == 0 && game.user_id == user.id
    end
    
    can :manage_confirmation_of, Round do |round|
      round.user_id == user.id
    end
    
    can :subscribe_to, Round do |round|
      !user.guest? && round.user_id != user.id && round.subscribable?
    end
    
    can :unsubscribe_to, Round do |round|
      !user.guest? && round.subscribers.include?(user) && !round.past?
    end
    
    can :read_email_of, User do |other_user|
      user.id == other_user.id || other_user.shows_email?
    end
  end
end