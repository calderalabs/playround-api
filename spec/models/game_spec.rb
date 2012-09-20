require 'spec_helper'

describe Game do
  before(:each) do
    stub_geocoder
    
    @game = FactoryGirl.build :game
  end

  # validity tests
  
  it "should be valid with valid attributes" do
    @game.should be_valid
  end
  
  it "should not be valid wihout a name" do
    @game.should validate_presence_of(:name)
  end
  
  it "should not be valid without a description" do
    @game.should validate_presence_of(:description)
  end

  it "should not be valid without a user" do
    @game.should validate_presence_of(:user_id)
  end
  
  it "name should not be more than 30 characters" do
    @game.should ensure_length_of(:name).is_at_most(30)
  end
  
  it "website should be a valid url" do
    assert_validates_url @game
  end
  
  it "website should be prefixed with the default schema if not present" do
    assert_adjusts_url @game
  end
  
  it "should be valid when website is blank" do
    @game.website = ''
    
    @game.should be_valid
  end
  
  it "should be valid when website is nil" do
    @game.website = nil
    
    @game.should be_valid
  end
  
  # attributes accessibility tests
  
  it "should not mass-assign user_id" do
    @game.should_not allow_mass_assignment_of(:user_id)
  end
  
  it "should mass-assign name" do
    @game.should allow_mass_assignment_of(:name)
  end
  
  it "should mass-assign website" do
    @game.should allow_mass_assignment_of(:website)
  end
  
  it "should mass-assign description" do
    @game.should allow_mass_assignment_of(:description)
  end
  
  it "should mass-assign image" do
    @game.should allow_mass_assignment_of(:image)
  end
  
  # associations tests
  
  it "should belong to user" do
    @game.should belong_to(:user)
  end
  
  it "should have many rounds" do
    @game.should have_many(:rounds)
  end
end