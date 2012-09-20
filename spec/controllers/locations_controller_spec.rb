require 'spec_helper'

describe LocationsController do
  it "should update user location if signed in" do
    user = FactoryGirl.create :user
    sign_in_as user
    
    Proc.new do
      put :update, :location => "Siena, Italy", :redirect_to => rounds_path
    end.should change(user, :town_woeid)
    
    should redirect_to(rounds_path)
  end
  
  it "should set location when update" do
    put :update, :location => "Siena, Italy", :redirect_to => rounds_path
    
    should redirect_to(rounds_path)
    session[:location].should_not be_nil
    session[:timezone].should_not be_nil
  end
end