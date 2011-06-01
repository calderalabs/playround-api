Then /^I should see my display name among the list of participants$/ do
  user = find_model('user: "me"')
  assert has_xpath?("//*[@id=\"participants\"]//*[text() = \"#{user.display_name}\"]")
end

Then /^I should not see my display name among the list of participants$/ do
  user = find_model('user: "me"')
  assert has_no_xpath?("//*[@id=\"participants\"]//*[text() = \"#{user.display_name}\"]")
end

Given /^I am subscribed to that round$/ do
  create_model("subscription", :user => find_model('user: "me"'), :round => Round.last)
end