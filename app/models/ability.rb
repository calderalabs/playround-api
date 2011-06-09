class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can [:read, :create], [Arena, Comment, Round, Game]
    can [:update, :destroy], [Arena, Comment, Round, Game], :user_id => user.id
    can :confirm, Round, :user_id => user.id
    can :update, User, :id => user.id
    can :manage_subscription_of, Round do |round|
      round.user_id != user.id
    end
  end
end
