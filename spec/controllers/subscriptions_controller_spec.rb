require 'spec_helper'

describe SubscriptionsController do
  before(:each) do
    stub_geocoder
    
    @user = Factory :user
    @round = Factory :round
    @controller.sign_in @user
  end
  
  it "should create subscription" do
    Proc.new do
      post :create, :id => @round.to_param
    end.should change(Subscription, :count).by(1)

    should respond_with(:found)
    should redirect_to(@round)
  end
  
  it "should not subscribe if you own the round" do
    post :create, :id => (Factory :round, :user => @user).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not create subscription if guest" do
    @controller.sign_out
    
    post :create, :id => @round.to_param

    should redirect_to(sign_in_url)
  end
  
  it "should destroy subscription" do
    Factory :subscription, :user => @user, :round => @round
    
    Proc.new do
      delete :destroy, :id => @round.to_param
    end.should change(Subscription, :count).by(-1)

    should respond_with(:found)
    should redirect_to(@round)
  end
  
  it "should not destroy subscription if guest" do
    @controller.sign_out
    
    delete :destroy, :id => @round.to_param

    should redirect_to(sign_in_url)
  end
end