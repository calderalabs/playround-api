require 'test_helper'

class ArenaTest < ActiveSupport::TestCase
  def setup
    Geocoder.stubs(:search).returns([Geocoder::Result::Google.new({})])
    RestClient.stubs(:get).returns(
    "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n
      <place xmlns=\"http://where.yahooapis.com/v1/schema.rng\" xmlns:yahoo=\"http://www.yahooapis.com/v1/base.rng\" yahoo:uri=\"http://where.yahooapis.com/v1/place/724196\" xml:lang=\"en-US\">
        <woeid>724196</woeid>
        <placeTypeName code=\"7\">Town</placeTypeName>
        <name>Siena</name>
        <country type=\"Country\" code=\"IT\">Italy</country>
        <admin1 type=\"Region\" code=\"\">Tuscany</admin1>
        <admin2 type=\"Province\" code=\"IT-SI\">Sienna</admin2>
        <admin3></admin3>
        <locality1 type=\"Town\">Siena</locality1>
        <locality2></locality2>
        <postal type=\"Postal Code\">53100</postal>
        <centroid>
          <latitude>43.325439</latitude>
          <longitude>11.330760</longitude>
        </centroid>
        <boundingBox>
          <southWest>
            <latitude>43.267311</latitude>
            <longitude>11.278400</longitude>
          </southWest>
          <northEast>
            <latitude>43.373798</latitude>
            <longitude>11.392120</longitude>
          </northEast>
        </boundingBox>
        <areaRank>4</areaRank>
        <popRank>10</popRank>
      </place>\n"
    )
    @user = mock_model(User)
    @user.stubs(:display_name => "matteodepalo", :email => "matteodepalo@mac.com", :password => "solidus")
    @arena = Factory :arena, :user => @user
  end
  
  def teardown
    @arena = nil
  end
  
  #validity tests
  
  test "arena should be valid with valid attributes" do
    assert @arena.valid?
  end
  
  test "should be invalid without a name" do
    @arena.name = nil
    
    assert @arena.invalid?
  end
  
  test "should be invalid without latitude" do
    @arena.latitude = nil
    
    assert @arena.invalid?
  end
  
  test "should be invalid without longitude" do
    @arena.longitude = nil
    
    assert @arena.invalid?
  end
  
  test "should be invalid without an address" do
    @arena.address = nil
    
    assert @arena.invalid?
  end
  
  test "should be invalid without a user" do
    @arena.user = nil
    
    assert @arena.invalid?
  end
  
  test "latitude should not be nil at creation" do
    arena = Arena.new
    
    assert_not_nil arena.latitude
  end
  
  test "longitude should not be nil at creation" do
    arena = Arena.new
    
    assert_not_nil arena.longitude
  end
  
  test "name should not be less than 3 characters" do
    @arena.name = 'Ab'
    
    assert @arena.invalid?
  end
  
  test "name should not be more than 30 characters" do
    @arena.name = 'a' * 35
    
    assert @arena.invalid?
  end
  
  test "latitude should not be less than -90" do
    @arena.latitude = -91
    
    assert @arena.invalid?
  end
  
  test "latitude should not be more than 90" do
    @arena.latitude = 91
    
    assert @arena.invalid?
  end
  
  test "longitude should not be less than -180" do
    @arena.longitude = -181
    
    assert @arena.invalid?
  end
  
  test "longitude should not be more than 180" do
    @arena.longitude = 181
    
    assert @arena.invalid?
  end
  
  test "website should be a valid url" do
    assert_validates_url @arena
  end
  
  test "website should be prefixed with the default schema if not present" do
    assert_adjusts_url @arena
  end
  
  test "should be valid when website is blank" do
    @arena.website = ''
    
    assert @arena.valid?
  end
  
  test "should be valid when website is nil" do
    @arena.website = nil
    
    assert @arena.valid?
  end
  
  #associations tests
  
  test "should have many rounds" do
    @arena.save!
    
    assert_has_many @arena, :rounds
  end
  
  test "should belong to user" do
    assert_belongs_to @arena, :user
  end
  
  #attributes accessibility tests
  
  test "should not mass-assign user_id" do
    user_id = @arena.user_id
    
    @arena.attributes = { :user_id => user_id + 1 }
    
    assert_equal @arena.user_id, user_id
  end
  
  #ability tests
  
  test "any user can create arenas" do
    ability = Ability.new Factory :user
    assert ability.can?(:create, Arena)
  end
  
  test "user can read any arena" do
    ability = Ability.new Factory :user
    assert ability.can?(:read, @arena)
    ability = Ability.new @arena.user
    assert ability.can?(:read, @arena)
  end
  
  test "user can only update arenas which he owns" do
    ability = Ability.new @arena.user
    assert ability.can?(:update, @arena)
    assert ability.cannot?(:update, Factory.build(:arena))
  end
  
  test "user can only destroy arenas which he owns" do
    ability = Ability.new @arena.user
    assert ability.can?(:destroy, @arena)
    assert ability.cannot?(:destroy, Factory.build(:arena))
  end
end