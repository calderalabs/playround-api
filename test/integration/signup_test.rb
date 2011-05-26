require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  test "successfull signup" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", :with => "matteodepalo@mac.com"
    fill_in "Password", :with => "solidus"
    click_button "Sign up"
    page.has_content? "You are now signed up"
  end
end
