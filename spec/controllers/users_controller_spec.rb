require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = FactoryGirl.create :user
    sign_in_as @user
  end
  
  it "should always get show user" do
    get :show, :id => @user.to_param
    
    should respond_with(:success)
    
    user = FactoryGirl.create :user
    
    get :show, :id => user.to_param
    
    should respond_with(:success)
    
    sign_out
    
    get :show, :id => @user.to_param
    
    should respond_with(:success)
  end
  
  it "should get edit if you own the user" do
    get :edit, :id => @user.to_param
    
    should respond_with(:success)
  end
  
  it "should not get edit if you don't own the user" do
    get :edit, :id => FactoryGirl.create(:user).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not get edit if guest" do
    sign_out
    
    get :edit, :id => @user.to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should update if you own the user" do
    put :update, :id => @user.to_param, :user => @user.accessible_attributes
    
    should respond_with(:found)
    should redirect_to(user_path(@user))
  end
  
  it "should not update if you don't own the user" do
    user = FactoryGirl.create :user
    put :update, :id => user.to_param, :user => user.accessible_attributes
    
    should redirect_to(sign_in_path)
  end
  
  it "should not update if guest" do
    sign_out
    
    put :update, :id => @user.to_param, :user => @user.attributes
    
    should redirect_to(sign_in_url)
  end
end