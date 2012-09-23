require 'spec_helper'

describe CommentsController do
  before(:each) do
    @comment = FactoryGirl.build :comment
    sign_in_as @comment.user
  end

  it "should create comment" do
    Proc.new do
      post :create, :comment => @comment.accessible_attributes
    end.should change(Comment, :count).by(1)
    
    should respond_with(:found)
    should redirect_to(round_path(assigns(:round))) 
  end
  
  it "should not create comment if guest" do
    sign_out
    
    post :create, :comment => @comment.accessible_attributes
    
    should redirect_to(sign_in_url)
  end

  it "should destroy if you own the comment" do
    @comment.save!

    Proc.new do
      delete :destroy, :id => @comment.to_param
    end.should change(Comment, :count).by(-1)

    should respond_with(:found)
    should redirect_to(round_path(assigns(:round)))
  end
  
  it "should not destroy if you don't own the comment" do
    delete :destroy, :id => FactoryGirl.create(:comment).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not destroy if guest" do
    @comment.save!
    sign_out
    
    delete :destroy, :id => @comment.to_param
    
    should redirect_to(sign_in_url)
  end
  
  # ability tests
  
  it "user can create comments" do
    ability = Ability.new FactoryGirl.create :user
    ability.should be_able_to(:create, Comment)
  end
  
  it "guests can't create comments" do
    ability = Ability.new User.new
    ability.should_not be_able_to(:create, Comment)
  end
  
  it "anyone can read any comment" do
    @comment.save!
    ability = Ability.new FactoryGirl.create :user
    ability.should be_able_to(:read, @comment)
    ability = Ability.new @comment.user
    ability.should be_able_to(:read, @comment)
    ability = Ability.new User.new
    ability.should be_able_to(:read, @comment)
  end
  
  it "user can only update comments which he owns" do
    @comment.save!
    ability = Ability.new @comment.user
    ability.should be_able_to(:update, @comment)
    ability.should_not be_able_to(:update, FactoryGirl.build(:comment))
  end
  
  it "user can only destroy comments which he owns" do
    @comment.save!
    ability = Ability.new @comment.user
    ability.should be_able_to(:destroy, @comment)
    ability.should_not be_able_to(:destroy, FactoryGirl.build(:comment))
  end
end