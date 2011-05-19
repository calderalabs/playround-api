require 'test_helper'
require 'validates_url_format_of'
require "#{File.expand_path(File.dirname(__FILE__))}/../init.rb"

class Model
  include ActiveModel::Validations
  
  extend ValidatesUrlFormatOf

  attr_accessor :website
  validates_url_format_of :website
end

class ValidatesUrlFormatOfTest < ActiveSupport::TestCase
  def setup
    @model = Model.new
  end
  
  test "should allow valid urls" do
    [
      'http://example.com',
      'http://example.com/',
      'http://www.example.com/',
      'http://sub.domain.example.com/',
      'http://bbc.co.uk',
      'http://example.com?foo',
      'http://example.com?url=http://example.com',
      'http://example.com:8000',
      'http://www.sub.example.com/page.html?foo=bar&baz=%23#anchor',
      'http://user:pass@example.com',
      'http://user:@example.com',
      'http://example.com/~user',
      'http://example.xy',  # Not a real TLD, but we're fine with anything of 2-6 chars
      'http://example.museum',
      'http://1.0.255.249',
      'http://1.2.3.4:80',
      'https://example.com',
      'http://xn--rksmrgs-5wao1o.nu',  # Punycode
      'http://www.xn--rksmrgs-5wao1o.nu',
      'http://foo.bar.xn--rksmrgs-5wao1o.nu',
      'http://example.com.',  # Explicit TLD root period
      'http://example.com./foo'
    ].each do |url|
      @model.website = url
      
      assert @model.valid?, url
    end
  end

  test "should reject invalid urls" do
    [
      "http://ex ample.com",
      "http://example.com/foo bar",
    ].each do |url|
      @model.website = url
     
      assert @model.invalid?, url
    end
  end
end
