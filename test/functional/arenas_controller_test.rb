require 'test_helper'

class ArenasControllerTest < ActionController::TestCase
  setup do
    @arena = Factory :arena
    @controller.sign_in @arena.user
  end

  test "should get index" do
    get :index
    
    assert_response :success
    assert_not_nil assigns(:arenas)
  end

  test "should get new" do
    get :new
    
    assert_response :success
  end

  test "should create arena" do
    assert_difference('Arena.count') do
      post :create, :arena => @arena.attributes
    end

    assert_response :found
    assert_redirected_to arena_path(assigns(:arena))
  end

  test "should always show arena" do
    get :show, :id => @arena.to_param
    
    assert_response :success
    
    arena = Factory :arena
    
    get :show, :id => arena.to_param
    
    assert_response :success
  end

  test "should get edit if you own the arena" do
    get :edit, :id => @arena.to_param
    
    assert_response :success
  end

  test "should not get edit if you don't own the arena" do
    get :edit, :id => Factory(:arena).to_param
    
    assert_response :unauthorized
  end

  test "should update if you own the arena" do
    put :update, :id => @arena.to_param, :arena => @arena.attributes
    
    assert_response :found
    assert_redirected_to arena_path(assigns(:arena))
  end
  
  test "should not update if you don't own the arena" do
    arena = Factory :arena
    put :update, :id => arena.to_param, :arena => arena.attributes
    
    assert_response :unauthorized
  end

  test "should destroy if you own the arena" do
    assert_difference('Arena.count', -1) do
      delete :destroy, :id => @arena.to_param
    end

    assert_response :found
    assert_redirected_to arenas_path
  end
  
  test "should not destroy if you don't own the arena" do
    delete :destroy, :id => Factory(:arena).to_param
    
    assert_response :unauthorized
  end
end