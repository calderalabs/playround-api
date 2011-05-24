require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = Factory :user
  end
  
  def teardown
    @user = nil
  end
 
  test "users should have many subscriptions" do
    Factory :subscription, :user => @user
    
    assert_has_many @user, :subscriptions
    
    assert_equal @user.subscriptions.first.user_id, @user.id
    
    assert_difference '@user.subscriptions.count' do
      Factory :subscription, :user => @user
    end  
  end
  
  test "should return the expected value on subscribed?" do
    round = Factory :round
    
    assert !@user.subscribed?(round)
    
    Factory :subscription, :user => @user, :round => round
    
    assert @user.subscribed?(round)
  end
end