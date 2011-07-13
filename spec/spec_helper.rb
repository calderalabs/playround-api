# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'clearance'
require 'capybara/rails'

Factory.find_definitions
require 'geoplanet'
require 'geocoder'
require 'geocoder/results/google'

require 'custom_matchers'
require 'cancan/matchers'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec
  
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  
  config.include CustomMatcher
end


#Capybara.default_driver = :selenium

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end

def assert_validates_url(record, key = :website)
  record.send("#{key}=", ':aaa')
  
  record.should be_invalid
  
  record.send("#{key}=", 'http:/www.google.com')
  
  record.should be_valid
  
  record.send("#{key}=", 'http:///www.google')
  
  record.should be_valid
  
  record.send("#{key}=", 'ftp://www.google.com')
  
  record.should be_invalid
end

def assert_adjusts_url(record, key = :website)
  record.send("#{key}=", 'www.google.com')
  
  record.save!
  
  record.send(key).should == 'http://www.google.com'
end

def stub_geocoder
  Geocoder.stub(:search).and_return([Geocoder::Result::Google.new({})])
  GeoPlanet::Place.stub(:search).and_return([GeoPlanet::Place.new({'woeid' => 724196, 'placeTypeName attrs' => {'code' => 7}})])
end