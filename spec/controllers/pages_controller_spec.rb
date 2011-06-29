require 'spec_helper'

describe PagesController do
  before(:each) do
    stub_geocoder
  end
  
  it "should get index" do
    @controller.sign_in Factory :user
    
    get :index
    
    should redirect_to(rounds_path)
  end
end