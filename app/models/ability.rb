class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :read, [Arena, Comment, Round, Game, User]
    
    can :create, [Arena, Comment, Round, Game] unless user.guest?
    
    can :update, [Arena, Comment, Round, Game], :user_id => user.id
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
      round.user_id == user.id && round.confirmable?
    end
    can :manage_subscription_of, Round do |round|
      !user.guest? && round.user_id != user.id
    end
  end
end