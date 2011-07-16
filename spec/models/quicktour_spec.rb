require 'spec_helper'

describe Quicktour do
  before(:each) do
    stub_geocoder
    
    @quicktour = Factory.build :quicktour
  end
  
  # validity tests
  
  it "should be valid at creation" do
    @quicktour.should be_valid
  end
  
  it "should have user_id" do
    @quicktour.should validate_presence_of(:user_id)
  end
  
  it "current_guider should be numeral" do
    @quicktour.should validate_numericality_of(:current_guider)
  end
  
  it "current_guider should not be fractional" do
    @quicktour.current_guider = 0.5
    
    @quicktour.should be_invalid
  end
  
  it "current_guider should be in range" do
    Quicktour.with_constants :GUIDERS => %w(a b c) do
      @quicktour.current_guider = -1
      @quicktour.should be_invalid
    
      @quicktour.current_guider = 0
      @quicktour.should be_valid
    
      @quicktour.current_guider = 1
      @quicktour.should be_valid
    
      @quicktour.current_guider = 3
      @quicktour.should be_invalid
    end
  end
  
  # association tests
  
  it "should belong to user" do
    @quicktour.should belong_to(:user)
  end
  
  # method tests
  
  it "should do something" do
    
  end
end
