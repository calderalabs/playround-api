class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :create, User if user.guest?
    can :create, [Round, Arena, Comment, Game, Subscription] unless user.guest?
    can :read, [Arena, Comment, Game, User]
    can :read, Round do |round|
      round.approved? || round.user_id == user.id
    end
    can :update, [Arena, Comment, Game, Quicktour, Round], :user_id => user.id
    can :update, User, :id => user.id
    can :destroy, [Arena, Comment, Game, Quicktour, Round, Subscription], :user_id => user.id
    can :read_email_of, User do |other_user|
      user.id == other_user.id || other_user.show_email
    end
    can :approve, Round, :arena => { :user_id => user.id }
    can :reject, Round, :arena => { :user_id => user.id }
    can :confirm, Round, :user_id => user.id
  end
end