Given /^I'm a guest$/ do
  
end

Then /^I should be able to sign up with email: "([^"]*)", password: "([^"]*)"$/ do |email, password|
  click_link "Sign up"
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign up"
end

Then /^I should be able to sign in with email: "([^"]*)", password: "([^"]*)"$/ do |email, password|
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign in"
end

Given /^I've logged in with email: "([^"]*)", password: "([^"]*)"$/ do |email, password|
  visit "/sign_in"
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign in"
end

Then /^I should be able to sign out$/ do
  click_link "Sign out"
end