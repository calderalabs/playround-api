Then /^I should see the details of that round$/ do
  round = Round.last
  
  Then "I should see \"#{round.name}\""
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

Then /^I should see my email among the list of participants$/ do
  user = find_model('user: "me"')
  Then "I should see \"#{user.email}\""
end

Then /^I should not see my email among the list of participants$/ do
  user = find_model('user: "me"')
  Then "I should not see \"#{user.email}\""
end

Given /^I am subscribed to that round$/ do
  create_model("subscription", :user => find_model('user: "me"'), :round => Round.last)
end