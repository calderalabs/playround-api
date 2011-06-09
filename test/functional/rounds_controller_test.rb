require 'test_helper'

class RoundsControllerTest < ActionController::TestCase
  setup do
    @round = Factory :round
    @controller.sign_in @round.user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create round" do
    assert_difference('Round.count') do
      post :create, :round => @round.attributes
    end

    assert_response :found
    assert_redirected_to round_path(assigns(:round))
  end

  test "should always show round" do
    get :show, :id => @round.to_param
    
    assert_response :success
    
    round = Factory :round
    
    get :show, :id => round.to_param
    
    assert_response :success
  end

  test "should get edit if you own the round" do
    get :edit, :id => @round.to_param
    
    assert_response :success
  end

  test "should not get edit if you don't own the round" do
    get :edit, :id => Factory(:round).to_param
    
    assert_response :unauthorized
  end

  test "should update if you own the round" do
    put :update, :id => @round.to_param, :round => @round.attributes
    
    assert_response :found
    assert_redirected_to round_path(assigns(:round))
  end
  
  test "should not update if you don't own the round" do
    round = Factory :round
    put :update, :id => round.to_param, :round => round.attributes
    
    assert_response :unauthorized
  end

  test "should destroy if you own the round" do
    assert_difference('Round.count', -1) do
      delete :destroy, :id => @round.to_param
    end

    assert_response :found
    assert_redirected_to rounds_path
  end
  
  test "should not destroy if you don't own the round" do
    delete :destroy, :id => Factory(:round).to_param
    
    assert_response :unauthorized
  end
  
  test "should confirm if you own the round" do
    put :confirm, :id => @round.to_param
    
    assert_response :found
    assert_redirected_to round_path(assigns(:round))
  end
  
  test "should not confirm if you don't own the round" do
    round = Factory :round
    put :confirm, :id => round.to_param
    
    assert_response :unauthorized
  end
    
end
