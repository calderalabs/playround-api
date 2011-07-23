require 'spec_helper'

describe "Round Mailer" do
  before(:each) do
    @round = Factory :round
    @user = Factory :user
    @subscription = Factory :subscription, :round => @round, :user => @user
  end
  
  it "should send confirmation email" do
    email = RoundMailer.round_confirmation_email(@round, @user).deliver
    ActionMailer::Base.deliveries.empty?.should == false
    email.subject.should == "Round confirmation"
    email.encoded.should match(/<h1>Hello #{@user.display_name}!<\/h1>/)
  end
end