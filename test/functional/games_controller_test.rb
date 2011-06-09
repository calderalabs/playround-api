require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = Factory :game
    @controller.sign_in Factory :user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, :game => @game.attributes
    end

    assert_response :found
    assert_redirected_to game_path(assigns(:game))
  end

  test "should always show game" do
    get :show, :id => @game.to_param
    
    assert_response :success
    
    game = Factory :game
    
    get :show, :id => game.to_param
    
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @game.to_param
    
    assert_response :success
  end

  test "should update" do
    put :update, :id => @game.to_param, :game => @game.attributes
    
    assert_response :found
    assert_redirected_to game_path(assigns(:game))
  end
 
end
