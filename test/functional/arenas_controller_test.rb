require 'test_helper'

class ArenasControllerTest < ActionController::TestCase
  setup do
    @arena = Factory :arena
    @controller.sign_in Factory :user
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

    assert_redirected_to arena_path(assigns(:arena))
  end

  test "should show arena" do
    get :show, :id => @arena.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @arena.to_param
    assert_response :success
  end

  test "should update arena" do
    put :update, :id => @arena.to_param, :arena => @arena.attributes
    assert_redirected_to arena_path(assigns(:arena))
  end

  test "should destroy arena" do
    assert_difference('Arena.count', -1) do
      delete :destroy, :id => @arena.to_param
    end

    assert_redirected_to arenas_path
  end
end
