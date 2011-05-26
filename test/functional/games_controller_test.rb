require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = Factory :game
    @controller.sign_in @game.user
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

  test "should get edit if you own the game" do
    get :edit, :id => @game.to_param
    
    assert_response :success
  end

  test "should not get edit if you don't own the game" do
    get :edit, :id => Factory(:game).to_param
    
    assert_response :unauthorized
  end

  test "should update if you own the game" do
    put :update, :id => @game.to_param, :game => @game.attributes
    
    assert_response :found
    assert_redirected_to game_path(assigns(:game))
  end
  
  test "should not update if you don't own the game" do
    game = Factory :game
    put :update, :id => game.to_param, :game => game.attributes
    
    assert_response :unauthorized
  end

  test "should destroy if you own the game" do
    assert_difference('Game.count', -1) do
      delete :destroy, :id => @game.to_param
    end

    assert_response :found
    assert_redirected_to games_path
  end
  
  test "should not destroy if you don't own the game" do
    delete :destroy, :id => Factory(:game).to_param
    
    assert_response :unauthorized
  end
end
