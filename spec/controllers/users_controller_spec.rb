require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = Factory :user
    @controller.sign_in @user
  end
  
  it "should always get show user" do
    get :show, :id => @user.to_param
    
    should respond_with(:success)
    
    user = Factory :user
    
    get :show, :id => user.to_param
    
    should respond_with(:success)
    
    @controller.sign_out
    
    get :show, :id => @user.to_param
    
    should respond_with(:success)
  end
  
  it "should get edit if you own the user" do
    get :edit, :id => @user.to_param
    
    should respond_with(:success)
  end
  
  it "should not get edit if you don't own the user" do
    get :edit, :id => Factory(:user).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not get edit if guest" do
    @controller.sign_out
    
    get :edit, :id => @user.to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should update if you own the user" do
    put :update, :id => @user.to_param, :user => @user.attributes
    
    should respond_with(:found)
    should redirect_to(user_path(@user))
  end
  
  it "should not update if you don't own the user" do
    user = Factory :user
    put :update, :id => user.to_param, :user => user.attributes
    
    should redirect_to(sign_in_path)
  end
  
  it "should not update if guest" do
    @controller.sign_out
    
    put :update, :id => @user.to_param, :user => @user.attributes
    
    should redirect_to(sign_in_url)
  end
end