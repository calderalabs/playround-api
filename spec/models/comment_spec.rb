require 'spec_helper'

describe "Comment" do
  before(:each) do
    stub_geocoder
    
    @comment = Factory.build :comment
  end
  
  # validity tests
  
  it "should not be valid with empty text" do
    @comment.should validate_presence_of(:text)
  end
  
  it "should not be valid without an user" do
    @comment.should validate_presence_of(:user_id)
  end
  
  it "should not be valid without a round" do
    @comment.should validate_presence_of(:round_id)
  end
  
  # attributes accessibility tests
  
  it "should not mass-assign user_id" do
    @comment.should_not allow_mass_assignment_of(:user_id)
  end
  
  it "should mass-assign text" do
    @comment.should allow_mass_assignment_of(:text)
  end
  
  it "should mass-assign round_id" do
    @comment.should allow_mass_assignment_of(:round_id)
  end
  
  # associations tests
  
  it "should belong to an user" do
    @comment.should belong_to(:user)
  end
  
  it "should belong to a round" do
    @comment.should belong_to(:round)
  end
  
  # ability tests
  
  it "user can create comments" do
    ability = Ability.new Factory :user
    ability.can?(:create, Comment).should == true
  end
  
  it "guests can't create comments" do
    ability = Ability.new User.new
    ability.cannot?(:create, Comment).should == true
  end
  
  it "anyone can read any comment" do
    ability = Ability.new Factory :user
    ability.can?(:read, @comment).should == true
    ability = Ability.new @comment.user
    ability.can?(:read, @comment).should == true
    ability = Ability.new User.new
    ability.can?(:read, @comment).should == true
  end
  
  it "user can only update comments which he owns" do
    ability = Ability.new @comment.user
    ability.can?(:update, @comment).should == true
    ability.cannot?(:update, Factory.build(:comment)).should == true
  end
  
  it "user can only destroy comments which he owns" do
    ability = Ability.new @comment.user
    ability.can?(:destroy, @comment).should == true
    ability.cannot?(:destroy, Factory.build(:comment)).should == true
  end
end
  

