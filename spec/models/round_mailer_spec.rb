require 'spec_helper'

describe "Round Mailer" do
  before(:each) do
    stub_geocoder
    
    @round = Factory :round
    @user = Factory :user
    @subscription = Factory :subscription, :round => @round, :user => @user
  end
  
  it "should send confirmation emails" do
    email = RoundMailer.round_confirmation_email(@round, @user).deliver
    
    ActionMailer::Base.deliveries.empty?.should == false
    email.subject.should == "Round confirmation"
    email.encoded.should match(/<h1>Hello #{@user.display_name}!<\/h1>/)
  end
  
  it "should send emails to subscribers when the owner of the round confirms" do
    5.times { Factory :subscription, :round => @round }
    Time.stub(:now).and_return(@round.deadline + 1.day)
    @round.confirm!
    @round.subscribers.each do |subscriber|
      should have_sent_email.with_subject(/Round confirmation/).from('info@playround.com').with_body(/Hello/).to(subscriber.email)
    end
  end
end