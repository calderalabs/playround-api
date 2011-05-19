require 'test_helper'
require 'adjusts_string'
require "#{File.expand_path(File.dirname(__FILE__))}/../init.rb"

class AdjustsStringTest < ActiveSupport::TestCase
  def model_with_options(options)
    Class.new do
      include ActiveModel::Validations
      include ActiveModel::Validations::Callbacks
  
      extend AdjustsString

      attr_accessor :example_string
      adjusts_string :example_string, options
    end
  end
  
  test "should prepend the supplied string" do
    model = model_with_options(:prepend => 'pre').new
    model.example_string = 'init'
    
    model.valid?
    
    assert_equal model.example_string, 'preinit'
  end
  
  test "should append the supplied string" do
    model = model_with_options(:append => 'pend').new
    model.example_string = 'init'
    
    model.valid?
    
    assert_equal model.example_string, 'initpend'
  end
  
  test "should capitalize the string" do
    model = model_with_options(:case => :capitalize).new
    model.example_string = 'init'
    
    model.valid?
    
    assert_equal model.example_string, 'Init'
  end
  
  test "should upcase the string" do
    model = model_with_options(:case => :upcase).new
    model.example_string = 'init'
    
    model.valid?
    
    assert_equal model.example_string, 'INIT'
  end
  
  test "should downcase the string" do
    model = model_with_options(:case => :downcase).new
    model.example_string = 'INIT'
    
    model.valid?
    
    assert_equal model.example_string, 'init'
  end
  
  test "should not do anything if string is blank and unless_blank is true" do
    model = model_with_options(:unless_blank => true, :prepend => 'pre').new
    model.example_string = ''
    
    model.valid?
    
    assert_equal model.example_string, ''
    
    model.example_string = 'init'
    
    model.valid?
    
    assert_equal model.example_string, 'preinit'
  end
  
  test "should do anyway if unless_blank is false and string is blank" do
    model = model_with_options(:unless_blank => false, :prepend => 'pre').new
    model.example_string = ''
    
    model.valid?
    
    assert_equal model.example_string, 'pre'
  end
  
  test "should do only if the condition is true" do
    model = model_with_options(:prepend => 'pre', :if => Proc.new { |m| false }).new
    model.example_string = 'init'
    
    model.valid?
    
    assert_equal model.example_string, 'init'
  end
end