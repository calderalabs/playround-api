require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    @subscription = Factory(:subscription)
  end
  
  def teardown
    @subscription = nil
  end
  
  test "factory should be valid" do
    assert @subscription.valid?
  end
  
  test "user_id should not be nil" do
    @subscription.user_id = nil
    
    assert @subscription.invalid?
  end
  
  test "round_id should not be nil" do
    @subscription.round_id = nil
    
    assert @subscription.invalid?
  end
  
  test "combination of user and round should be unique" do
    @another_subscription = Factory.build(:subscription , :user => @subscription.user, :round => @subscription.round)
    
    assert @another_subscription.invalid?
  end
  
  test "should belong to user" do
    assert_belongs_to @subscription, :user, User
    
    assert_equal @subscription.user_id, @subscription.user.id
  end
  
  test "should belong to round" do
    assert_belongs_to @subscription, :round, Round
    
    assert_equal @subscription.round_id, @subscription.round.id
  end
end
