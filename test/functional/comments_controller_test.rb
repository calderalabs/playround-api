require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @comment = Factory :comment
    @controller.sign_in @comment.user
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, :comment => @comment.attributes
    end

    assert_response :found
    assert_redirected_to round_path(assigns(:round))
  end

  test "should destroy if you own the comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, :id => @comment.to_param
    end

    assert_response :found
    assert_redirected_to round_path(assigns(:round))
  end
  
  test "should not destroy if you don't own the comment" do
    delete :destroy, :id => Factory(:comment).to_param
    
    assert_response :unauthorized
  end
end
