require 'spec_helper'

describe ConfirmationController do
  before(:each) do
    stub_geocoder
    
    @round = Factory :round, :deadline => Time.now
    @controller.sign_in @round.user
  end
  
  it "should confirm if you own the round" do
    @round.confirmable?.should == true

    post :create, :round_id => @round.to_param

    should respond_with(:found)
    should redirect_to(round_path(assigns(:round)))
    flash[:notice].should == 'Round was successfully confirmed.'
    assigns(:round).confirmed.should == true
  end

  it "should not confirm if the current time is before the deadline" do
    @round.date = Time.now + 2.months
    @round.deadline = Time.now + 1.month
    @round.save!

    post :create, :round_id => @round.to_param

    should redirect_to(sign_in_url)
  end

  it "should not confirm if the current time is after the date" do
    @round.date = Time.now + 1.second
    @round.deadline = Time.now
    @round.save!

    Time.stub(:now).and_return(@round.date + 10.seconds)
    post :create, :round_id => @round.to_param

    should redirect_to(sign_in_url)
  end

  it "should not confirm if you don't own the round" do
    round = Factory :round
    post :create, :round_id => round.to_param

    should redirect_to(sign_in_url)
  end

  it "should not confirm if guest" do
    round = Factory :round
    post :create, :round_id => round.to_param

    should redirect_to(sign_in_url)
  end
end
