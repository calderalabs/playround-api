require 'spec_helper'

describe ApprovalsController do
  before(:each) do
    @user = FactoryGirl.create :user
    @arena = FactoryGirl.create :arena, :user => @user
    @round = FactoryGirl.create :round, :arena => @arena
  end
  
  it "should approve the round if you're the owner of the arena" do
    @controller.sign_in @user
    post :create, :round_id => @round.to_param
    
    @round.reload
    @round.approved?.should == true
    should set_the_flash.to(/approved/i)
    should redirect_to(dashboards_path(@user))
  end
  
  it "should not approve the round if you're not the owner of the arena" do
    @controller.sign_in FactoryGirl.create :user
    post :create, :round_id => @round.to_param
    
    @round.reload
    @round.approved?.should == false
    should_not set_the_flash.to(/approved/i)
    should redirect_to(sign_in_path)
  end
end
