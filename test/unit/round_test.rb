require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  def setup
    @round = rounds(:dota)
  end
  
  def teardown
    @round = nil
  end
  
  test "fixture should be valid" do
    assert @round.valid?
  end
  
  test "should not be valid without a name" do
    @round.name = nil
    
    assert @round.invalid?
  end
  
   test "should not be valid without a deadline" do
    @round.deadline = nil
    
    assert @round.invalid?
  end
  
  test "should not be valid without a date" do
    @round.date = nil
    
    assert @round.invalid?
  end
  
  test "should not be valid without maximum people" do
    @round.max_people = nil
    
    assert @round.invalid?
  end
  
  test "should not be valid without minimum people" do
    @round.min_people = nil
    
    assert @round.invalid?
  end
  
  test "should not be valid without an arena" do
    @round.arena = nil
    
    assert @round.invalid?
  end
  
  test "minimum people should not be nil at creation" do
    round = Round.new
    
    assert_not_nil round.min_people
  end
  
  test "maximum people should not be nil at creation" do
    round = Round.new
    
    assert_not_nil round.max_people
  end
  
  test "confirmed should not be nil at creation" do
    round = Round.new
    
    assert_not_nil round.confirmed
  end
  
  test "date should not be nil at creation" do
    round = Round.new
    
    assert_not_nil round.date
  end
  
  test "deadline should not be nil at creation" do
    round = Round.new
    
    assert_not_nil round.deadline
  end
  
  test "confirmed should be false at creation" do
    round = Round.new
    
    assert round.confirmed == false
  end
  
  test "minimum people should be less than maximum" do
    @round.min_people = 2
    @round.max_people = 1
    
    assert @round.invalid?
  end
  
  test "people should not be less than 1" do
    @round.min_people = 0
    @round.max_people = -1
    
    assert @round.invalid?
  end
  
  test "minimum people should not be fractional" do
    @round.min_people = 0.5
    
    assert @round.invalid?
  end
  
  test "maximum people should not be fractional" do
    @round.max_people = 0.5
    
    assert @round.invalid?
  end
  
  test "name should not be less than 3 characters" do
    @round.name = 'Ab'
    
    assert @round.invalid?
  end
  
  test "name should not be more than 30 characters" do
    @round.name = 'a' * 35
    
    assert @round.invalid?
  end
  
  test "deadline should be before or at the same time of date" do
    @round.deadline = 1.hour.since(@round.date)
    
    assert @round.invalid?
  end
  
  test "name should begin with a capital letter after save" do
    @round.name = 'abc'
    
    @round.save!
    
    assert @round.name == 'Abc'
  end
  
  test "should belong to an arena" do
    assert_belongs_to @round, :arena, Arena
    
    @round.arena = arenas(:tearoom)
    
    assert_equal @round.arena_id, @round.arena.id
    assert_equal @round.arena.name, 'Tea Room'
  end
end
