require 'spec_helper'

describe Round do
  before(:each) do
    @user = Factory :user
    @round = Factory.build :round, :user => @user
  end
  
  # Validations
  
  it "should be valid with factory attributes" do
    assert @round.valid?
  end

  it "should validate presence of date" do
    @round.should validate_presence_of(:date)
  end
  
  it "should validate presence of people" do
    @round.should validate_presence_of(:people)
  end
  
  it "should validate presence of arena" do
    @round.should validate_presence_of(:arena_id)
  end
  
  it "should validate presence of game" do
    @round.should validate_presence_of(:game_id)
  end
  
  it "should validate presence of user" do
    @round.should validate_presence_of(:user_id)
  end
  
  it "should have 2 people by default" do
    Round.new.people.should == 2
  end
  
  it "should have the current time as the default date" do
    now = Time.now.change(:sec => 0)
    Time.stub(:now).and_return(now)
    Round.new.date.should == now
  end
  
  it "should not be approved by default" do
    Round.new.approved.should == false
  end
  
  it "should not be rejected by default" do
    Round.new.rejected.should == false
  end
  
  it "should not be confirmed by default" do
    Round.new.confirmed.should == false
  end
  
  it "should not have less than 2 people" do
    @round.people = 1
    @round.should be_invalid
  end
  
  it "should validate numericality of people" do
    @round.should validate_numericality_of(:people)
  end
  
  it "should not have a fractional number of people" do
    @round.people = 0.5
    @round.should be_invalid
  end
  
  it "should not have a past date as its date" do
    @round.date = Time.now - 1.day
    @round.should be_invalid
  end
  
  it "should be created on a public arena or on an arena created by the round owner" do
    @round.arena = Factory :arena, :public => true
    @round.should be_valid
    @round.arena = Factory :arena, :public => false
    @round.should_not be_valid
    @round.arena = Factory :arena, :public => false, :user => @user
    @round.should be_valid
  end
  
  # Mass assignment
  
  it "should not allow mass assignment of user" do
    @round.should_not allow_mass_assignment_of(:user_id)
  end
  
  it "should allow mass assignment of date" do
    @round.should allow_mass_assignment_of(:date)
  end
  
  it "should allow mass assignment of people" do
    @round.should allow_mass_assignment_of(:people)
  end
  
  it "should allow mass assignment of arena" do
    @round.should allow_mass_assignment_of(:arena_id)
  end
  
  it "should allow mass assignment of game" do
    @round.should allow_mass_assignment_of(:game_id)
  end
  
  it "should allow mass assignment of description" do
    @round.should allow_mass_assignment_of(:description)
  end
  
  it "should not allow mass assignment of approved" do
    @round.should_not allow_mass_assignment_of(:approved)
  end
  
  it "should not allow mass assignment of confirmed" do
    @round.should_not allow_mass_assignment_of(:confirmed)
  end
  
  it "should not allow mass assignment of rejected" do
    @round.should_not allow_mass_assignment_of(:rejected)
  end
  
  # Associations
  
  it "should belong to an arena" do
    @round.should belong_to(:arena)
  end
  
  it "should belong to a game" do
    @round.should belong_to(:game)
  end
 
  it "should have many subscriptions" do
    @round.should have_many(:subscriptions)
  end
  
  it "should belong to an user" do
    @round.should belong_to(:user)
  end
  
  it "should have many comments" do
    @round.should have_many(:comments)
  end
  
  it "should have many subscribers through subscriptions" do
    @round.should have_many(:subscribers).through(:subscriptions)
  end
  
  # Methods
  
  it "should be full when subscribers are equal to the number of people" do
    @round.full?.should == false
    @round.people.times { @round.subscriptions << Factory.build(:subscription) }
    @round.full?.should == true
  end
  
  it "should decrease remaining spots when someone subscribes" do
    Proc.new { @round.subscriptions << Factory.build(:subscription) }.should change(@round, :remaining_spots).by(-1)
  end
  
  it "should be past after the date" do
    @round.past?.should == false
    Time.stub(:now).and_return(@round.date + 1.day)
    @round.past?.should == true
  end
  
  it "shoud not be subscribable when the round is full" do
    @round.approve!
    @round.subscribable_by?(@user).should == true
    @round.people.times { Factory :subscription, :round => @round }
    @round.subscribable_by?(@user).should == false
  end
  
  it "should not be subscribable after the date" do
    @round.approve!
    @round.subscribable_by?(@user).should == true
    Time.stub(:now).and_return(@round.date + 1.day)
    @round.subscribable_by?(@user).should == false
  end
  
  it "should be listed in pending approval when it is not approved and not rejected" do
    @round.save!
    Round.pending_approval.should include(@round)
  end
  
  it "should not be listed in pending approval when it is approved" do
    @round.approved = true
    @round.save!
    Round.pending_approval.should_not include(@round)
  end
  
  it "should not be listed in pending approval when it is rejected" do
    @round.rejected = true
    @round.save!
    Round.pending_approval.should_not include(@round)
  end
  
  it "should be listed in approved when it is approved" do
    @round.approved = true
    @round.save!
    Round.approved.should include(@round)
  end
  
  it "should be listed in rejected when it is rejected" do
    @round.rejected = true
    @round.save!
    Round.rejected.should include(@round)
  end
  
  it "should not be listed in approved when it is not approved" do
    @round.save!
    Round.approved.should_not include(@round)
  end
  
  it "should not be listed in rejected when it is not rejected" do
    @round.save!
    Round.rejected.should_not include(@round)
  end
  
  it "should be approved automatically when it's created by the owner of the arena" do
    @round.user = @round.arena.user
    @round.save!
    @round.approved?.should == true
  end
  
  it "should not be approved automatically when it's created by another user" do
    @round.save!
    @round.approved?.should == false
  end
end