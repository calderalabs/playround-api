require 'spec_helper'

describe DashboardController do
  before(:each) do
    stub_geocoder
    
    @user = Factory :user
    @controller.sign_in @user
  end
  
  it "should get index" do
    get :index, :id => @user.to_param
    
    should respond_with(:success)
  end
end
