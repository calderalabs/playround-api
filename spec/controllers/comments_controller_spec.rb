require 'spec_helper'

describe CommentsController do
  before(:each) do
    stub_geocoder
    
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
end