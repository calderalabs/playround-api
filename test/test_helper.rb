ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
Factory.find_definitions

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_validates_url(record, key = :website)
    record.send("#{key}=", ':aaa')
    
    assert record.invalid?
    
    record.send("#{key}=", 'http:/www.google.com')
    
    assert record.valid?
    
    record.send("#{key}=", 'http:///www.google')
    
    assert record.valid?
    
    record.send("#{key}=", 'ftp://www.google.com')
    
    assert record.invalid?
  end
  
  def assert_adjusts_url(record, key = :website)
    record.send("#{key}=", 'www.google.com')
    
    record.save!
    
    assert_equal record.send(key), 'http://www.google.com'
  end
  
  def assert_has_many(record, key)
    assert_respond_to record, key

    assert_kind_of Array, record.send(key) 
  end
  
  def assert_belongs_to(record, key, klass)
    assert_respond_to record, key
    
    assert_kind_of klass, record.send(key)
  end
end