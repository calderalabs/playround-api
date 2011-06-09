require 'test_helper'

class RoundMailerTest < ActionMailer::TestCase
  def setup
    @round = Factory :round
    @user = Factory :user
    @subscription = Factory :subscription, :round => @round, :user => @user
  end
  
  test "round confirmation email" do
    email = RoundMailer.round_confirmation_email(@round, @user).deliver
    
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal "Round confirmation", email.subject
    assert_match /<h1>Hello #{@user.display_name}!<\/h1>/, email.encoded
  end
end
