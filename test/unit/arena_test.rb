require 'test_helper'

class ArenaTest < ActiveSupport::TestCase
  def setup
    @arena = arenas(:tearoom)
  end
  
  def teardown
    @arena = nil
  end
  
  test "record should be invalid at creation" do
    arena = Arena.new
    
    assert arena.invalid?
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
    @arena.website = ':aaa'
    
    assert @arena.invalid?
    
    @arena.website = 'http:/www.google.com'
    
    assert @arena.valid?
    
    @arena.website = 'http:///www.google'
    
    assert @arena.valid?
    
    @arena.website = 'www.google.com'
    
    assert @arena.valid?
    
    @arena.website = 'ftp://www.google.com'
    
    assert @arena.invalid?
  end
  
  test "record should be valid when website is blank" do
    @arena.website = ''
    
    assert @arena.valid?
  end
  
  test "record should be valid when website is nil" do
    @arena.website = nil
    
    assert @arena.valid?
  end
end