require 'spec_helper'

describe "Round Mailer" do
  before(:each) do
    @round = FactoryGirl.create :approved_round
    @user = FactoryGirl.create :user
  end
  
  after(:each) do
    ActionMailer::Base.deliveries.clear
  end
  
  it "should send confirmation email" do
    RoundMailer.confirmation_email(@round, @user).deliver
    should have_sent_email.with_subject(/confirmation/).from('info@playround.com').with_body(/take place in #{@round.arena.name}/).to("#{@user.email}")
  end
  
  it "should send emails to subscribers after confirmation" do
    @round.remaining_spots.times { @round.subscriptions << FactoryGirl.build(:subscription) }
    @round.confirm!
    @round.subscribers.each do |s|
      should have_sent_email.with_subject(/confirmation/).from('info@playround.com').with_body(/take place in #{@round.arena.name}/).to("#{s.email}")
    end
  end
end