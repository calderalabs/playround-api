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
    
    Factory :subscription, :user => @user
    
    assert_has_many @user, :subscriptions
    
    assert_equal @user.subscriptions.first.user_id, @user.id
    
    assert_difference '@user.subscriptions.count' do
      Factory :subscription, :user => @user
    end  
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
    
    Factory :round, :user => @user
    
    assert_has_many @user, :rounds
    
    assert_equal @user.rounds.first.user_id, @user.id
    
    assert_difference '@user.rounds.count' do
      Factory :round, :user => @user
    end
  end
  
  test "should have many games" do
    @user.save!
    
    Factory :game, :user => @user
    
    assert_has_many @user, :games
    
    assert_equal @user.games.first.user_id, @user.id
    
    assert_difference '@user.games.count' do
      Factory :game, :user => @user
    end
  end
  
  test "should have many arenas" do
    @user.save!
    
    Factory :arena, :user => @user
    
    assert_has_many @user, :arenas
    
    assert_equal @user.arenas.first.user_id, @user.id
    
    assert_difference '@user.arenas.count' do
      Factory :arena, :user => @user
    end
  end
end