require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = Factory.build :user, :email => "matteodepalo@gmail.com"
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
  
  test "should have many comments" do
    @user.save!
    
    assert_has_many @user, :comments
  end
  
  test "display name should not be allowed to be blank" do
    @user.display_name = ''
    
    assert @user.invalid?
  end
  
  test "real name should not be longer than 30 characters" do
    @user.real_name = "a" * 35
    
    assert @user.invalid?
  end
  
  test "real name should not be shorter than 3 characters" do
    @user.real_name = "aa"
    
    assert @user.invalid?
  end
  
  test "real name should be allowed to be blank" do
    @user.real_name = nil
    
    assert @user.valid?
    
    @user.real_name = ''
    
    assert @user.valid?
  end
  
  test "display name should be some reasonable default at creation" do
    @user.save!
    
    assert_equal "matteodepalo", @user.display_name
  end
end