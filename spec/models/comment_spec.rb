require 'spec_helper'

describe "Comment" do
  before(:each) do
    @round = mock_model('Round')
    @comment = Factory.build :comment, :round => @round
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
end
  

