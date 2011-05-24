require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  setup do
    @user = Factory :user
    @round = Factory :round
    @controller.sign_in @user
  end
  
  test "should create subscription" do
    assert_difference('Subscription.count') do
      post :create, :id => @round.id
    end

    assert_redirected_to @round
  end
  
  test "should destroy subscription" do
    Factory :subscription, :user => @user, :round => @round
    
    assert_difference('Subscription.count', -1) do
      delete :destroy, :id => @round.id
    end

    assert_redirected_to @round
  end
end
