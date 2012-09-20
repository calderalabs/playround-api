require 'spec_helper'

describe PagesController do
  it "should get index" do
    sign_in_as FactoryGirl.create :user
    
    get :index
    
    should redirect_to(rounds_path)
  end
end