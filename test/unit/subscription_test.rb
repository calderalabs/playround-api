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
  
  test "not allow to subscribe to a full round" do
    @subscription.round.max_people.times do
      Factory(:subscription, :round => @subscription.round)
    end
    
    assert @subscription.invalid?
  end
  
  test "any user can create subscriptions" do
    ability = Ability.new Factory :user
    assert ability.can?(:create, Subscription)
  end
  
  test "user can only destroy subscriptions which he owns" do
    ability = Ability.new @subscription.user
    assert ability.can?(:destroy, @subscription)
    assert ability.cannot?(:destroy, Factory.build(:subscription))
  end
end