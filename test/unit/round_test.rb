require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  def setup
    @round = Factory.build :round
  end
  
  def teardown
    @round = nil
  end
  
  test "factory should be valid" do
    assert @round.valid?
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
  
  test "should not be valid without a game" do
    @round.game = nil
    
    assert @round.invalid?
  end
  
  test "should not be able to mass-assign user_id" do
    user_id = @round.user_id
    
    @round.attributes = { :user_id => user_id + 1 }
    
    assert_equal @round.user_id, user_id 
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
  
  test "people should not be less than 2" do
    @round.min_people = 1
    @round.max_people = 1
    
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
  
  test "deadline should be before or at the same time of date" do
    @round.deadline = 1.hour.since(@round.date)
    
    assert @round.invalid?  
    assert @round.errors[:deadline].include? "must be earlier than date"
  end
  
  test "should belong to an arena" do
    assert_belongs_to @round, :arena
  end
  
  test "should belong to a game" do
    assert_belongs_to @round, :game
  end
  
  test "deadline should not be before now" do
    @round.deadline = Time.now - 1.day
    
    assert @round.invalid?
  end
  
  test "date should not be before now" do
    @round.date = Time.now - 1.day
    
    assert @round.invalid?
  end
  
  test "deadline and date should be equal on creation" do
    assert_equal @round.date, @round.deadline
  end
 
  test "rounds should have many subscriptions" do
    @round.save!
    
    assert_has_many @round, :subscriptions
  end
  
  test "should be full when subscribers are equal to max_people" do
    @round.save!
    
    assert !@round.full?
    
    @round.remaining_spots.times do
      Factory(:subscription, :round => @round)
    end
    
    @round.reload
    
    assert @round.full?
  end
  
  test "should belong to user" do
    assert_belongs_to @round, :user
  end
  
  test "only the user who created the round should be able to manage it" do
    @round.save!
    
    assert @round.authorized?(@round.user)
    
    assert !@round.authorized?(Factory :user)
  end
  
  test "should be invalid without a user" do
    @round.user = nil
    
    assert @round.invalid?
  end
  
  test "any user can create rounds" do
    ability = Ability.new Factory :user
    assert ability.can?(:create, Round)
  end
  
  test "user can read any round" do
    ability = Ability.new Factory :user
    assert ability.can?(:read, @round)
    ability = Ability.new @round.user
    assert ability.can?(:read, @round)
  end
  
  test "user can only update rounds which he owns" do
    ability = Ability.new @round.user
    assert ability.can?(:update, @round)
    assert ability.cannot?(:update, Factory.build(:round))
  end
  
  test "user can only destroy rounds which he owns" do
    ability = Ability.new @round.user
    assert ability.can?(:destroy, @round)
    assert ability.cannot?(:destroy, Factory.build(:round))
  end
  
  test "should have many comments" do
    @round.save!
    
    assert_has_many @round, :comments
  end
  
  test "should confirm if confirmed is false" do
    assert_equal @round.confirmed, false
    
    assert @round.confirm!
    
    assert_equal @round.confirmed, true
  end
  
  test "should not confirm if confirmed is true" do
    @round.confirm!
    
    assert_equal @round.confirmed, true
    
    assert !@round.confirm!
    
    assert_equal @round.confirmed, true
  end
  
  test "should have many subscribers through subscriptions" do
    @round.save!
    
    assert_has_many_through @round, :subscribers, :source_class_name => 'Subscription'
  end
  
  test "all subscribers should include the owner" do
    assert @round.all_subscribers.include?(@round.user)
  end
  
  test "all subscribers should include a subscriber" do
    @round.save!

    @subscription = Factory :subscription, :round => @round
 
    @round.reload
 
    assert @round.subscribers.include?(@subscription.user)
  end
  
  test "should decrease remaining spots when someone subscribes" do
    @round.save!
    
    assert_difference '@round.remaining_spots', -1 do
      @subscription = Factory :subscription, :round => @round
      
      @round.reload
    end
  end
end