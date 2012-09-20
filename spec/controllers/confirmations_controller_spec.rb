require 'spec_helper'

describe ConfirmationsController do
  before(:each) do
    @round = FactoryGirl.create :approved_round
  end
  
  it "should confirm if you own the round" do
    sign_in_as @round.user
    @round.remaining_spots.times { FactoryGirl.create :subscription, :round => @round }

    post :create, :round_id => @round.to_param
    round = assigns(:round)
    round.reload
    should redirect_to(round_path(round))
    round.confirmed?.should == true
  end

  it "should not confirm if round is not full" do
    sign_in_as @round.user

    post :create, :round_id => @round.to_param
    round = assigns(:round)
    round.reload
    should redirect_to(round)
    round.confirmed?.should_not == true
  end

  it "should not confirm if you don't own the round" do
    sign_in_as FactoryGirl.create :user
    post :create, :round_id => @round.to_param

    should redirect_to(sign_in_url)
  end

  it "should not confirm if guest" do
    post :create, :round_id => @round.to_param

    should redirect_to(sign_in_url)
  end
end
