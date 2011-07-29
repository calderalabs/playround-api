require 'spec_helper'

describe ConfirmationsController do
  before(:each) do
    @round = Factory :approved_round
  end
  
  it "should confirm if you own the round" do
    @controller.sign_in @round.user
    @round.remaining_spots.times { Factory :subscription, :round => @round }

    post :create, :round_id => @round.to_param
    round = assigns(:round)
    round.reload
    should redirect_to(round_path(round))
    round.confirmed?.should == true
  end

  it "should not confirm if round is not full" do
    @controller.sign_in @round.user

    post :create, :round_id => @round.to_param
    round = assigns(:round)
    round.reload
    should redirect_to(round)
    round.confirmed?.should_not == true
  end

  it "should not confirm if you don't own the round" do
    @controller.sign_in Factory :user
    post :create, :round_id => @round.to_param

    should redirect_to(sign_in_url)
  end

  it "should not confirm if guest" do
    post :create, :round_id => @round.to_param

    should redirect_to(sign_in_url)
  end
end
