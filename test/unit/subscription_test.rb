require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    @subscription = Factory.build :subscription
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
  
  test "should not mass-assign user_id" do
    user_id = @subscription.user_id
        
    @subscription.attributes = { :user_id => user_id + 1 }
    
    assert_equal @subscription.user_id, user_id
  end
  
  test "combination of user and round should be unique" do
    @subscription.save!
    
    @another_subscription = Factory.build(:subscription , :user => @subscription.user, :round => @subscription.round)
    
    assert @another_subscription.invalid?
  end
  
  test "should belong to user" do
    assert_belongs_to @subscription, :user
  end
  
  test "should belong to round" do
    assert_belongs_to @subscription, :round
  end
  
  test "should not allow to subscribe to a full round" do
    @subscription.round.remaining_spots.times do
      Factory(:subscription, :round => @subscription.round)
    end
    
    @subscription.round.reload
    
    assert @subscription.invalid?
  end
  
  test "any user can create subscriptions" do
    ability = Ability.new Factory :user
    assert ability.can?(:manage_subscription_of, Round)
  end
  
  test "user can destroy subscriptions which he owns" do
    ability = Ability.new @subscription.user
    assert ability.can?(:manage_subscription_of, @subscription.round)
  end
end