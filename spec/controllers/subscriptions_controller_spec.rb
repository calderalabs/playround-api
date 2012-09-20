require 'spec_helper'

describe SubscriptionsController do
  before(:each) do
    @user = FactoryGirl.create :user
    @round = FactoryGirl.create :approved_round, :user => @user
  end
  
  it "should subscribe to the round when logged in" do
    sign_in_as @user
    
    post :create, :round_id => @round.to_param
    @round.subscribers(true).should include(@user)
    should set_the_flash.to(/subscribed/i)
    should redirect_to(@round)
  end
  
  it "should not subscribe to the round when not logged in" do
    post :create, :round_id => @round.to_param
    should redirect_to(sign_in_url)
  end
  
  it "should unsubscribe to the round when logged in" do
    sign_in_as @user
    @round.subscriptions << FactoryGirl.build(:subscription, :user => @user, :round => nil)
    @round.save!
    
    delete :destroy, :round_id => @round.to_param
    @round.subscribers(true).should_not include(@user)
    should set_the_flash.to(/no longer subscribed/i)
    should redirect_to(@round)
  end
  
  it "should not unsubscribe when not logged in" do
    delete :destroy, :round_id => @round.to_param
    should redirect_to(sign_in_url)
  end
  
  # Abilities
  
  it "registered users can subscribe to rounds" do
    ability = Ability.new @user
    ability.should be_able_to(:create, Subscription)
  end
  
  it "guests can't subscribe to rounds" do
    ability = Ability.new User.new
    ability.should_not be_able_to(:destroy, @user.subscriptions.build(:round_id => @round.id))
  end
end