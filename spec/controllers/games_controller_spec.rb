require 'spec_helper'

describe GamesController do
  before(:each) do
    @game = FactoryGirl.build :game
    sign_in_as @game.user
  end

  it "should get index" do
    @game.save!
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
      post :create, :game => @game.accessible_attributes
    end.should change(Game, :count).by(1)
    
    should respond_with(:found)
    should redirect_to(game_path(assigns(:game)))
  end
  
  it "should not create if guest" do
    sign_out
    
    post :create, :game => @game.accessible_attributes
    
    should redirect_to(sign_in_url)
  end

  it "should always show game" do
    @game.save!
    get :show, :id => @game.to_param
    
    should respond_with(:success)
    
    game = FactoryGirl.create :game
    
    get :show, :id => game.to_param
    
    should respond_with(:success)
    
    sign_out
    
    get :show, :id => @game.to_param
    
    should respond_with(:success)
  end

  it "should get edit if you own the game" do
    @game.save!
    get :edit, :id => @game.to_param

    should respond_with(:success)
  end

  it "should not get edit if you don't own the game" do
    get :edit, :id => FactoryGirl.create(:game).to_param

    should redirect_to(sign_in_url)
  end
  
  it "should not get edit if guest" do
    @game.save!
    sign_out
    
    get :edit, :id => @game.to_param
    
    should redirect_to(sign_in_url)
  end

  it "should update if you own the game" do
    @game.save!
    put :update, :id => @game.to_param, :game => @game.accessible_attributes

    should respond_with(:found)
    should redirect_to(game_path(assigns(:game)))
  end

  it "should not update if you don't own the game" do
    game = FactoryGirl.create :game
    put :update, :id => game.to_param, :game => game.accessible_attributes

    should redirect_to(sign_in_url)
  end
  
  it "should not update if guest" do
    @game.save!
    sign_out
    
    put :update, :id => @game.to_param, :game => @game.accessible_attributes
    
    should redirect_to(sign_in_url)
  end
  
  it "should destroy if you own the game" do
    @game.save!

    Proc.new do
      delete :destroy, :id => @game.to_param
    end.should change(Game, :count).by(-1)
    
    should respond_with(:found)
    should redirect_to(games_path)
  end

  it "should not destroy if you don't own the game" do
    delete :destroy, :id => FactoryGirl.create(:game).to_param

    should redirect_to(sign_in_url)
  end
  
  it "should not destroy if there is at least one round with that game" do
    @game.save!

    FactoryGirl.create :round, :game => @game
    
    delete :destroy, :id => @game.to_param
    
    should redirect_to(@game)
  end
  
  it "should not destroy if guest" do
    @game.save!
    sign_out
    
    delete :destroy, :id => @game.to_param
    
    should redirect_to(sign_in_url)
  end
  
  # ability tests
  
  it "user can create games" do
    ability = Ability.new FactoryGirl.create :user
    ability.should be_able_to(:create, Game)
  end
  
  it "guests can't create games" do
    ability = Ability.new User.new
    ability.should_not be_able_to(:create, Game)
  end
  
  it "anyone can read any game" do
    @game.save!
    ability = Ability.new FactoryGirl.create :user
    ability.should be_able_to(:read, @game)
    ability = Ability.new @game.user
    ability.should be_able_to(:read, @game)
    ability = Ability.new User.new
    ability.should be_able_to(:read, @game)
  end
  
  it "user can only update games which he owns" do
    @game.save!
    ability = Ability.new @game.user
    ability.should be_able_to(:update, @game)
    ability.should_not be_able_to(:update, FactoryGirl.build(:game))
  end
  
  it "user can only destroy games which he owns" do
    @game.save!
    ability = Ability.new @game.user
    ability.should be_able_to(:destroy, @game)
    ability.should_not be_able_to(:destroy, FactoryGirl.build(:game))
  end
end