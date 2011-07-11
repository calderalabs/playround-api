Then /^I should see the details of that arena$/ do
  arena = Arena.last
  
  Then "I should see \"#{arena.name}\""
  Then "I should see \"#{arena.description}\""
end

Then /^I should not see that arena listed$/ do
  And "I should not see \"#{Arena.last.name}\""
end

Then /^I should see that arena listed$/ do
  And "I should see \"#{Arena.last.name}\""
end

When /^I select that arena from "([^"]*)"$/ do |field|
  select Arena.last.name, :from => field
end

When /^I set an arena's image$/ do
  attach_file('arena_image', File.join(File.expand_path(File.dirname(__FILE__)), "colosseum.jpg"))
end

Then /^I should see the arena's image$/ do
  assert has_xpath?("//img[contains(@src, \"colosseum.jpg\")]")
end