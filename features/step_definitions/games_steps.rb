Then /^I should see the details of that game$/ do
  game = Game.last
  
  Then "I should see \"#{game.name}\""
  Then "I should see \"#{game.description}\""
end

Then /^I should not see that game listed$/ do
  And "I should not see \"#{Game.last.name}\""
end

When /^I select that game from "([^"]*)"$/ do |field|
  select Game.last.name, :from => field
end