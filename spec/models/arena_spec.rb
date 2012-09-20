require 'spec_helper'

describe Arena do
  before(:each) do
    stub_geocoder
    
    @arena = FactoryGirl.build :arena
  end
  
  # validity tests
  
  it "should be valid with valid attributes" do
    @arena.should be_valid
  end
  
  it "should be invalid without a name" do
    @arena.should validate_presence_of(:name)
  end
  
  it "should be invalid without latitude" do
    @arena.should validate_presence_of(:latitude)
  end
  
  it "should be invalid without longitude" do
    @arena.should validate_presence_of(:longitude)
  end
  
  it "should be invalid without an address" do
    @arena.should validate_presence_of(:address)
  end
  
  it "should be invalid without a user" do
    @arena.should validate_presence_of(:user_id)
  end
  
  it "should be valid when website is blank" do
    @arena.website = ''
    
    @arena.should be_valid
  end
  
  it "should be valid when website is nil" do
    @arena.website = nil
    
    @arena.should be_valid
  end
  
  it "latitude should not be nil at creation" do
    arena = Arena.new
    
    assert_not_nil arena.latitude
  end
  
  it "longitude should not be nil at creation" do
    arena = Arena.new
    
    assert_not_nil arena.longitude
  end
  
  it "name should not be less than 3 and not more than 30 characters" do
    @arena.should ensure_length_of(:name).is_at_least(3).is_at_most(30)
  end
  
  it "latitude should be a number" do
    @arena.should validate_numericality_of(:latitude)
  end
  
  it "longitude should be a number" do
    @arena.should validate_numericality_of(:longitude)
  end
  
  it "latitude should not be less than -90" do
    @arena.latitude = -91
    
    @arena.should be_invalid
  end
  
  it "latitude should not be more than 90" do
    @arena.latitude = 91
    
    @arena.should be_invalid
  end
  
  it "longitude should not be less than -180" do
    @arena.longitude = -181
    
    @arena.should be_invalid
  end
  
  it "longitude should not be more than 180" do
    @arena.longitude = 181
    
    @arena.should be_invalid
  end
  
  it "website should be a valid url" do
    assert_validates_url @arena
  end
  
  it "website should be prefixed with the default schema if not present" do
    assert_adjusts_url @arena
  end
  
  it "public should be false at creation" do
    arena = Arena.new
    arena.public.should == false
  end
  
  # attributes accessibility tests
  
  it "should not mass-assign user_id" do
    @arena.should_not allow_mass_assignment_of(:user_id)
  end
  
  it "should mass-assign name" do
    @arena.should allow_mass_assignment_of(:name)
  end
  
  it "should mass-assign latitude" do
    @arena.should allow_mass_assignment_of(:latitude)
  end
  
  it "should mass-assign longitude" do
    @arena.should allow_mass_assignment_of(:longitude)
  end
  
  it "should mass-assign address" do
    @arena.should allow_mass_assignment_of(:address)
  end
  
  it "should mass-assign town_woeid" do
    @arena.should allow_mass_assignment_of(:town_woeid)
  end
  
  it "should mass-assign public" do
    @arena.should allow_mass_assignment_of(:public)
  end
  
  it "should mass-assign website" do
    @arena.should allow_mass_assignment_of(:website)
  end
  
  it "should mass-assign description" do
    @arena.should allow_mass_assignment_of(:description)
  end
  
  it "should mass-assign image" do
    @arena.should allow_mass_assignment_of(:image)
  end
  
  # associations tests
  
  it "should have many rounds" do
    @arena.should have_many(:rounds)
  end
  
  it "should belong to user" do
    @arena.should belong_to(:user)
  end
end