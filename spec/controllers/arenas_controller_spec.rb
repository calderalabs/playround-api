require 'spec_helper'

describe ArenasController do
  before(:each) do
    stub_geocoder
    
    @arena = Factory :arena
    @controller.sign_in @arena.user
  end
  
  # RESTful methods tests
  
  it "should get index" do
    get :index
    
    should respond_with(:success)
    assigns(:arenas).should_not be_nil
  end

  it "should get new" do
    get :new
    
    should respond_with(:success)
  end
  
  it "should not get new if guest" do
    @controller.sign_out
    
    get :new
    
    should redirect_to(sign_in_url)
  end

  it "should create arena" do
    Proc.new do
      post :create, :arena => @arena.attributes
    end.should change(Arena, :count).by(1)

    should respond_with(:found)
    should redirect_to(arena_path(assigns(:arena)))
  end
  
  it "should not create arena if guest" do
    @controller.sign_out
    
    post :create, :arena => @arena.attributes
    
    should redirect_to(sign_in_url)
  end

  it "should always show arena" do
    get :show, :id => @arena.to_param
    
    should respond_with(:success)
    
    arena = Factory :arena
    
    get :show, :id => arena.to_param
    
    should respond_with(:success)
    
    @controller.sign_out
    
    get :show, :id => @arena.to_param
    
    should respond_with(:success)
  end

  it "should get edit if you own the arena" do
    get :edit, :id => @arena.to_param
    
    should respond_with(:success)
  end

  it "should not get edit if you don't own the arena" do
    get :edit, :id => Factory(:arena).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not get edit if guest" do
    @controller.sign_out
    
    get :edit, :id => @arena.to_param
    
    should redirect_to(sign_in_url)
  end

  it "should update if you own the arena" do
    put :update, :id => @arena.to_param, :arena => @arena.attributes
    
    should respond_with(:found)
    should redirect_to(arena_path(assigns(:arena)))
  end
  
  it "should not update if you don't own the arena" do
    arena = Factory :arena
    put :update, :id => arena.to_param, :arena => arena.attributes
    
    should redirect_to(sign_in_url)
  end
  
  it "should not update if guest" do
    @controller.sign_out
    
    put :update, :id => @arena.to_param, :arena => @arena.attributes
    
    should redirect_to(sign_in_url)
  end

  it "should destroy if you own the arena" do
    Proc.new do
      delete :destroy, :id => @arena.to_param
    end.should change(Arena, :count).by(-1)
    
    should respond_with(:found)
    should redirect_to(arenas_path)
  end
  
  it "should not destroy if you don't own the arena" do
    delete :destroy, :id => Factory(:arena).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not destroy if guest" do
    @controller.sign_out
    
    delete :destroy, :id => @arena.to_param
    
    should redirect_to(sign_in_url)
  end
end