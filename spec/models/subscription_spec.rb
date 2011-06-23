describe "Subscription" do
  before(:each) do
    stub_geocoder
    
    @subscription = Factory.build :subscription
  end
  
  # validity tests
  
  it "should be valid with valid attributes" do
    @subscription.should be_valid
  end
  
  it "should not be valid without user_id" do
    @subscription.should validate_presence_of(:user_id)
  end
  
  it "should not be valid without round_id" do
    @subscription.should validate_presence_of(:round_id)
  end
  
  it "combination of user and round should be unique" do
    @subscription.save!
    
    @another_subscription = Factory.build :subscription, :round => @subscription.round, :user => @subscription.user
    
    @another_subscription.should be_invalid
  end
  
  # attributes accessibility tests
  
  it "should not mass-assign user_id" do
    @subscription.should_not allow_mass_assignment_of(:user_id)
  end
  
  it "should mass-assign round_id" do
    @subscription.should allow_mass_assignment_of(:round_id)
  end
  
  # associations tests
  
  it "should belong to user" do
    @subscription.should belong_to(:user)
  end
  
  it "should belong to round" do
    @subscription.should belong_to(:round)
  end
  
  # ability tests
  
  it "user can create subscriptions" do
    ability = Ability.new Factory :user
    ability.can?(:manage_subscription_of, Factory(:round)).should == true
  end
  
  it "guests can't create subscriptions" do
    ability = Ability.new User.new
    ability.cannot?(:manage_subscription_of, Factory(:round)).should == true
  end
  
  it "user can destroy only subscriptions which he owns" do
    ability = Ability.new @subscription.user
    ability.can?(:manage_subscription_of, @subscription.round).should == true
  end
  
  it "user can't subscribe to his own round" do
    user = Factory :user
    ability = Ability.new user
    ability.cannot?(:manage_subscription_of, Factory(:round, :user => user)).should == true
  end
end