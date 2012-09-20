require 'spec_helper'

describe AdjustString::ModelAdditions do
  def model_with_options(options)
    Class.new(SuperModel::Base) do
      include ActiveModel::Validations::Callbacks
      extend AdjustString::ModelAdditions

      attr_accessor :example_string
      adjusts_string :example_string, options
    end
  end

  it "should prepend the supplied string" do
    model = model_with_options(:prepend => 'pre').new
    model.example_string = 'init'
    
    model.should be_valid
    model.example_string.should == 'preinit'
  end
  
  it "should append the supplied string" do
    model = model_with_options(:append => 'pend').new
    model.example_string = 'init'
    
    model.should be_valid
    model.example_string.should == 'initpend'
  end
  
  it "should capitalize the string" do
    model = model_with_options(:case => :capitalize).new
    model.example_string = 'init'
    
    model.should be_valid
    model.example_string.should == 'Init'
  end
  
  it "should upcase the string" do
    model = model_with_options(:case => :upcase).new
    model.example_string = 'init'
    
    model.should be_valid
    model.example_string.should == 'INIT'
  end
  
  it "should downcase the string" do
    model = model_with_options(:case => :downcase).new
    model.example_string = 'INIT'
    
    model.should be_valid
    model.example_string.should == 'init'
  end
  
  it "should not do anything if string is blank and unless_blank is true" do
    model = model_with_options(:unless_blank => true, :prepend => 'pre').new
    model.example_string = ''
    
    model.should be_valid
    model.example_string.should == ''
    
    model.example_string = 'init'

    model.should be_valid
    model.example_string.should == 'preinit'
  end
  
  it "should do anyway if unless_blank is false and string is blank" do
    model = model_with_options(:unless_blank => false, :prepend => 'pre').new
    model.example_string = ''
    
    model.should be_valid
    model.example_string.should == 'pre'
  end
  
  it "should do only if the condition is true" do
    model = model_with_options(:prepend => 'pre', :if => Proc.new { |m| false }).new
    model.example_string = 'init'
    
    model.should be_valid
    model.example_string.should == 'init'
  end
end