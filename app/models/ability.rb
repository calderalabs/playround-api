class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :read, [Arena, Comment, Round, Game]
    can :create, [Arena, Comment, Round, Game] unless user.guest?
    can :update, Game unless user.guest?
    can [:update, :destroy], [Arena, Comment, Round], :user_id => user.id
    can :confirm, Round do |round|
      round.user_id == user.id && round.confirmable?
    end
    can :update, User, :id => user.id
    can :manage_subscription_of, Round do |round|
      round.user_id != user.id
    end
  end
end
