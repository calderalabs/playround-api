require 'test_helper'

class GameTest < ActiveSupport::TestCase
  def setup
    @game = games(:dota)
  end
  
  test "fixture should be valid" do
    assert @game.valid?
  end
  
  test "should not be valid wihout a name" do
    @game.name = nil
    
    assert @game.invalid?
  end
  
  test "should not be valid without a description" do
    @game.description = nil
    
    assert @game.invalid?
  end
  
  test "name should not be more than 30 characters" do
    @game.name = 'a' * 35
    
    assert @game.invalid?
  end
  
  test "name should be capitalized after save" do
    @game.name = 'go'
    
    @game.save!
    
    assert_equal @game.name, 'Go'
  end
  
  test "website should be a valid url" do
    assert_validates_url @game
  end
  
  test "website should be prefixed with the default schema if not present" do
    assert_adjusts_url @game
  end
  
  test "record should be valid when website is blank" do
    @game.website = ''
    
    assert @game.valid?
  end
  
  test "record should be valid when website is nil" do
    @game.website = nil
    
    assert @game.valid?
  end
  
  test "should have many rounds" do
    assert_has_many @game, :rounds
    
    assert_equal @game.rounds.first.game_id, @game.id
    assert_equal @game.rounds.first.game.name, 'DotA'
    
    @game.rounds = []
    
    assert_difference '@game.rounds.count' do
      @game.rounds << rounds(:risk)
    end
  end
  
end
