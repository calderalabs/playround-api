require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = Factory.build :comment
  end
  
  def teardown
    @comment = nil
  end
  
  test "should not be valid with empty text" do
    @comment.text = nil
    assert @comment.invalid?
    
    @comment.text = ''
    assert @comment.invalid?
  end
  
  test "should not be valid without an user" do
    @comment.user = nil
    assert @comment.invalid?
  end
  
  test "should not be valid without a round" do
    @comment.round = nil
    assert @comment.invalid?
  end
  
  test "should not mass-assign user_id" do
    user_id = @comment.user_id
    
    @comment.attributes = { :user_id => user_id + 1 }
    
    assert_equal @comment.user_id, user_id
  end
  
  test "should belong to an user" do
    assert_belongs_to @comment, :user
  end
  
  test "should belong to a round" do
    assert_belongs_to @comment, :round
  end
end
