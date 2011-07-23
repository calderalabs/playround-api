require 'spec_helper'

describe DashboardsController do
  before(:each) do
    @user = Factory :user
    @controller.sign_in @user
  end
  
  it "should get index" do
    get :index, :user_id => @user.to_param
    
    should render_template('index')
    should respond_with(:success)
  end
end
