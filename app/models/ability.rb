class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can [:read, :create], :all
    can [:update, :destroy], :all, :user_id => user.id
    
  end
end
