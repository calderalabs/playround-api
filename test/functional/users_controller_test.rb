require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = Factory :user
    @controller.sign_in @user
  end
  
  test "should get show user" do
    get :show, :id => @user.to_param
    
    assert_response :success
  end
  
  test "should get edit if you own the user" do
    get :edit, :id => @user.to_param
    
    assert_response :success
  end
  
  test "should update if you own the user" do
    put :update, :id => @user.to_param, :user => @user.attributes
    
    assert_response :found
    assert_redirected_to user_path(@user)
  end
end
