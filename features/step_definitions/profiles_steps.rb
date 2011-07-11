Then /^I should see an empty picture$/ do
  assert has_xpath?("//img[contains(@src, \"missing_avatar.gif\")]")
end

Then /^I should see my avatar$/ do
  assert has_xpath?("//img[contains(@src, \"justin-bieber.jpg\")]")
end

When /^I set my avatar$/ do
  attach_file('user_avatar', File.join(File.expand_path(File.dirname(__FILE__)), "justin-bieber.jpg"))
end

Then /^I should see the details of that user$/ do
  user = User.last
  
  Then "I should see \"#{user.display_name}\""
  And "I should see \"#{user.real_name}\""
end