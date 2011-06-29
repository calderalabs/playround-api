require 'spec_helper'

describe GamesController do
  before(:each) do
    stub_geocoder
    
    @game = Factory :game
    @controller.sign_in @game.user
  end

  it "should get index" do
    get :index
    should respond_with(:success)
    assigns(:games).should_not be_nil
  end

  it "should get new" do
    get :new
    should respond_with(:success)
  end
  
  it "should not get new if guest" do
    
  end

  it "should create game" do
    Proc.new do
      post :create, :game => @game.attributes
    end.should change(Game, :count).by(1)
    
    should respond_with(:found)
    should redirect_to(game_path(assigns(:game)))
  end
  
  it "should not create if guest" do
    @controller.sign_out
    
    post :create, :game => @game.attributes
    
    should redirect_to(sign_in_url)
  end

  it "should always show game" do
    get :show, :id => @game.to_param
    
    should respond_with(:success)
    
    game = Factory :game
    
    get :show, :id => game.to_param
    
    should respond_with(:success)
    
    @controller.sign_out
    
    get :show, :id => @game.to_param
    
    should respond_with(:success)
  end

  it "should get edit if you own the game" do
    get :edit, :id => @game.to_param

    should respond_with(:success)
  end

  it "should not get edit if you don't own the game" do
    get :edit, :id => Factory(:game).to_param

    should redirect_to(sign_in_url)
  end
  
  it "should not get edit if guest" do
    @controller.sign_out
    
    get :edit, :id => @game.to_param
    
    should redirect_to(sign_in_url)
  end

  it "should update if you own the game" do
    put :update, :id => @game.to_param, :game => @game.attributes

    should respond_with(:found)
    should redirect_to(game_path(assigns(:game)))
  end

  it "should not update if you don't own the game" do
    game = Factory :game
    put :update, :id => game.to_param, :game => game.attributes

    should redirect_to(sign_in_url)
  end
  
  it "should not update if guest" do
    @controller.sign_out
    
    put :update, :id => @game.to_param, :game => @game.attributes
    
    should redirect_to(sign_in_url)
  end
  
  it "should destroy if you own the game" do
    Proc.new do
      delete :destroy, :id => @game.to_param
    end.should change(Game, :count).by(-1)
    
    should respond_with(:found)
    should redirect_to(games_path)
  end

  it "should not destroy if you don't own the game" do
    delete :destroy, :id => Factory(:game).to_param

    should redirect_to(sign_in_url)
  end
  
  it "should not destroy if guest" do
    @controller.sign_out
    
    delete :destroy, :id => @game.to_param
    
    should redirect_to(sign_in_url)
  end
end