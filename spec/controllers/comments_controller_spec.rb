require 'spec_helper'

describe CommentsController do
  before(:each) do
    @comment = Factory :comment
    @controller.sign_in @comment.user
  end

  it "should create comment" do
    Proc.new do
      post :create, :comment => @comment.attributes
    end.should change(Comment, :count).by(1)
    
    should respond_with(:found)
    should redirect_to(round_path(assigns(:round))) 
  end
  
  it "should not create comment if guest" do
    @controller.sign_out
    
    post :create, :comment => @comment.attributes
    
    should redirect_to(sign_in_url)
  end

  it "should destroy if you own the comment" do
    Proc.new do
      delete :destroy, :id => @comment.to_param
    end.should change(Comment, :count).by(-1)

    should respond_with(:found)
    should redirect_to(round_path(assigns(:round)))
  end
  
  it "should not destroy if you don't own the comment" do
    delete :destroy, :id => Factory(:comment).to_param
    
    should redirect_to(sign_in_url)
  end
  
  it "should not destroy if guest" do
    @controller.sign_out
    
    delete :destroy, :id => @comment.to_param
    
    should redirect_to(sign_in_url)
  end
  
  # ability tests
  
  it "user can create comments" do
    ability = Ability.new Factory :user
    ability.should be_able_to(:create, Comment)
  end
  
  it "guests can't create comments" do
    ability = Ability.new User.new
    ability.should_not be_able_to(:create, Comment)
  end
  
  it "anyone can read any comment" do
    ability = Ability.new Factory :user
    ability.should be_able_to(:read, @comment)
    ability = Ability.new @comment.user
    ability.should be_able_to(:read, @comment)
    ability = Ability.new User.new
    ability.should be_able_to(:read, @comment)
  end
  
  it "user can only update comments which he owns" do
    ability = Ability.new @comment.user
    ability.should be_able_to(:update, @comment)
    ability.should_not be_able_to(:update, Factory.build(:comment))
  end
  
  it "user can only destroy comments which he owns" do
    ability = Ability.new @comment.user
    ability.should be_able_to(:destroy, @comment)
    ability.should_not be_able_to(:destroy, Factory.build(:comment))
  end
end