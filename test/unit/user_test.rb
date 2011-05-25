require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = Factory.build :user
  end
  
  def teardown
    @user = nil
  end
 
  test "users should have many subscriptions" do
    @user.save!

    assert_has_many @user, :subscriptions 
  end
  
  test "should return the expected value on subscribed?" do
    @user.save!
    
    round = Factory :round
    
    assert !@user.subscribed?(round)
    
    Factory :subscription, :user => @user, :round => round
    
    assert @user.subscribed?(round)
  end
  
  test "should have many rounds" do
    @user.save!
    
    assert_has_many @user, :rounds
  end
  
  test "should have many games" do
    @user.save!
    
    assert_has_many @user, :games
  end
  
  test "should have many arenas" do
    @user.save!
    
    assert_has_many @user, :arenas
  end
end