Then /^I should see the details of that round$/ do
  round = Round.last
  
  Then "I should see \"#{round.user.display_name}\""
  And "I should see \"#{round.max_people}\""
  And "I should see \"#{round.min_people}\""
  And "I should see \"#{round.game.name}\""
  And "I should see \"#{round.arena.name}\""
end

Then /^I should not see that round listed$/ do
  round = Round.last
  
  Then "I should not see \"#{round.game.name}\""
  And "I should not see \"#{round.arena.name}\""
end

Then /^I should see that round listed$/ do
  round = Round.last
  
  Then "I should see \"#{round.game.name}\""
  And "I should see \"#{round.arena.name}\""
  And "I should see \"#{round.user.display_name}\""
end

Given /^that user created a round with a past deadline$/ do
  now = Time.now
  Time.stub(:now).and_return(now - 1.month)
  Factory :round, :deadline => Time.now + 1.day, :date => Time.now + 2.months, :user => User.last
  Time.unstub(:now)
end

Given /^that user created a round with a past date$/ do
  now = Time.now
  Time.stub(:now).and_return(now - 1.month)
  Factory :round, :deadline => Time.now + 1.day, :date => Time.now + 2.weeks, :user => User.last
  Time.unstub(:now)
end

Given /^that user created a round with a past date and confirmed it$/ do
  now = Time.now
  Time.stub(:now).and_return(now - 1.month)
  round = Factory :round, :deadline => Time.now + 1.day, :date => Time.now + 2.weeks, :user => User.last
  Time.stub(:now).and_return(now - 3.weeks)
  round.confirm!
  Time.unstub(:now)
end

Given /^a user created a round in that arena$/ do
  Factory :round, :arena => Arena.last
end
