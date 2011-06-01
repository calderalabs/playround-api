Then /^I should see the details of that round$/ do
  round = Round.last
  
  Then "I should see \"#{round.name}\""
  And "I should see \"#{round.user.display_name}\""
  And "I should see \"#{round.max_people}\""
  And "I should see \"#{round.min_people}\""
  And "I should see \"#{round.game.name}\""
  And "I should see \"#{round.arena.name}\""
end

Then /^I should not see that round listed$/ do
  Then "I should not see \"#{Round.last.name}\""
  And "I should not see \"#{Game.last.name}\""
  And "I should not see \"#{Arena.last.name}\""
end