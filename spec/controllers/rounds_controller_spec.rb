require 'spec_helper'

describe RoundsController do
  before(:each) do
    @user = Factory :user
    @round = Factory.build :round, :user => @user
  end

  # Actions

  it "should display rounds list page" do
    get :index
    assigns(:rounds).should_not be_nil
    should respond_with(:success)
    response.should render_template(:index)
  end

  it "should display round creation page when logged in" do
    @controller.sign_in @user
    
    get :new
    assigns(:round).should_not be_nil
    should respond_with(:success)
    response.should render_template(:new)
  end
  
  it "should not display round creation page when not logged in" do
    get :new
    should redirect_to(sign_in_url)
  end

  it "should create round when logged in" do
    @controller.sign_in @user
    
    post :create, :round => @round.attributes
    round = assigns(:round)
    Round.all.should include(round)
    should set_the_flash.to(/created/i)
    should redirect_to(round)
  end

  it "should display round details page" do
    @round.save!
    
    get :show, :id => @round.to_param
    should respond_with(:success)
    
    @controller.sign_in @user
    get :show, :id => @round.to_param
    should respond_with(:success)
    
    @controller.sign_in Factory :user
    get :show, :id => @round.to_param
    should respond_with(:success)
  end

  it "should display round editing page when you own it" do
    @round.save!
    
    @controller.sign_in @user
    get :edit, :id => @round.to_param
    should respond_with(:success)
  end

  it "should not display round editing page when you don't own it" do
    @round.save!
    
    @controller.sign_in Factory :user
    get :edit, :id => @round.to_param
    should redirect_to(sign_in_url)
  end
  
  it "should not display round editing page when not logged in" do
    @round.save!
    
    get :edit, :id => @round.to_param
    should redirect_to(sign_in_url)
  end

  it "should update the round when you own it" do
    @round.save!
    
    @controller.sign_in @user
    put :update, :id => @round.to_param, :round => { :description => 'Amazing description' }
    @round.reload
    @round.description.should == 'Amazing description'
    should set_the_flash.to(/updated/i)
    should redirect_to(@round)
  end
  
  it "should not update the round when you don't own it" do
    @round.save!
    
    @controller.sign_in Factory :user
    put :update, :id => @round.to_param, :round => { :description => 'Amazing description' }
    @round.reload
    @round.description.should_not == 'Amazing description'
    should_not set_the_flash.to(/updated/i)
    should redirect_to(sign_in_url)
  end
  
  it "should not update the round when not logged in" do
    @round.save!
    
    put :update, :id => @round.to_param, :round => { :description => 'Amazing description' }
    @round.reload
    @round.description.should_not == 'Amazing description'
    should_not set_the_flash.to(/updated/i)
    should redirect_to(sign_in_url)
  end
  
  it "should destroy the round when you own it" do
    @round.save!
    
    @controller.sign_in @user
    delete :destroy, :id => @round.to_param
    Round.all.should_not include(@round)
    should redirect_to(rounds_path)
  end
  
  it "should not destroy the round when you don't own it" do
    @round.save!
    
    @controller.sign_in Factory :user
    delete :destroy, :id => @round.to_param
    Round.all.should include(@round)
    should redirect_to(sign_in_url)
  end
  
  it "should not destroy the round when there is at least one subscriber" do
    @round.save!
    @round.subscriptions << Factory.build(:subscription, :round => nil)
    
    @controller.sign_in @user
    delete :destroy, :id => @round.to_param
    Round.all.should include(@round)
    should redirect_to(@round)
  end
  
  it "should not destroy when not logged in" do
    @round.save!
    
    delete :destroy, :id => @round.to_param
    Round.all.should include(@round)
    should redirect_to(sign_in_url)
  end
  
  # Abilities
  
  it "registered users can create rounds" do
    ability = Ability.new @user
    ability.can?(:create, Round).should == true
  end

  it "guests can't create rounds" do
    ability = Ability.new User.new
    ability.cannot?(:create, Round).should == true
  end

  it "anyone can read any round" do
    @round.save!
    
    ability = Ability.new @user
    ability.can?(:read, @round).should == true
    ability = Ability.new User.new
    ability.can?(:read, @round).should == true
  end

  it "registered users can only update rounds which they own" do
    @round.save!

    ability = Ability.new @user
    ability.can?(:update, @round).should == true
    ability = Ability.new Factory :user
    ability.cannot?(:update, @round).should == true
  end
end