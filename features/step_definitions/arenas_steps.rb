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