describe "Game" do
  before(:each) do
    @user = mock_model('User')
    @game = Factory.build :game, :user => @user
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
end