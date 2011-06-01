When /^I click the "([^"]*)" link in the comments box$/ do |link|
  within '#comments' do
    click_link link
  end
end

Given /^a comment for that round exists with text: "([^"]*)" created by "([^"]*)"$/ do |text, user|
  create_model("comment", :text => text, :user => "user: \"#{user}\"", :round => model!("round"))
end

Then /^I should see "([^"]*)"'s display name in the comments box$/ do |user|
  within '#comments' do
    display_name = find_model("user: \"#{user}\"").display_name
    assert has_xpath?("//*[@id=\"comments\"]//*[text() = \"#{display_name}\"]")
  end
end