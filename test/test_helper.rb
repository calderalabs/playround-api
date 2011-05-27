ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Factory.find_definitions
require 'capybara/rails'

#Capybara.default_driver = :selenium

class ActionDispatch::IntegrationTest
  include Capybara
end

class ActiveSupport::TestCase
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
  
  def assert_has_many(record, attribute, options = {})
    assert_respond_to record, attribute
    
    class_name = options[:class_name] || ActiveSupport::Inflector.classify(attribute.to_s)
    foreign_key = options[:foreign_key] || ActiveSupport::Inflector.foreign_key(record.class.name)
    
    assert_kind_of Array, record.send(attribute)
    
    assert_difference "record.#{attribute}.count" do
      Factory class_name.underscore.to_sym, foreign_key => record.id
    end
  end
  
  def assert_belongs_to(record, attribute, options = {})
    class_name = options[:class_name] || ActiveSupport::Inflector.classify(attribute.to_s)
    class_constant = ActiveSupport::Inflector.constantize(class_name)
    foreign_key = options[:foreign_key] || ActiveSupport::Inflector.foreign_key(attribute.to_s)
    
    assert_respond_to record, attribute
    
    assert_kind_of class_constant, record.send(attribute)
    
    assert_equal record.send(foreign_key), record.send(attribute).id
  end
end