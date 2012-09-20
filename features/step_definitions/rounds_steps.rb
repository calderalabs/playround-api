Then /^I should see the details of that round$/ do
  round = Round.last
  
  Then "I should see \"#{round.user.display_name}\""
  And "I should see \"#{round.people}\""
  And "I should see \"#{round.game.name}\""
  And "I should see \"#{round.arena.name}\""
end

Then /^I should not see that round listed$/ do
  if round = Round.last
    Then "I should not see \"#{round.game.name}\""
    And "I should not see \"#{round.arena.name}\""
  end
end

Then /^I should see that round listed$/ do
  round = Round.last
  
  Then "I should see \"#{round.game.name}\""
  And "I should see \"#{round.arena.name}\""
  And "I should see \"#{round.user.display_name}\""
end

Given /^that user created a round that is past$/ do
  now = Time.now
  Time.stub(:now).and_return(now - 1.month)
  FactoryGirl.create :round, :date => Time.now, :user => User.last
  Time.unstub(:now)
end

Given /^that user created a round that is past and full$/ do
  now = Time.now
  Time.stub(:now).and_return(now - 1.month)
  round = FactoryGirl.create :round, :date => Time.now + 1.week, :user => User.last, :approved => true
  round.remaining_spots.times { FactoryGirl.create :subscription, :round => round }
  Time.unstub(:now)
end

Given /^that user created a round that is full$/ do
  round = FactoryGirl.create :round, :user => User.last, :approved => true
  round.remaining_spots.times { FactoryGirl.create :subscription, :round => round }
end

Given /^a user created a round in that arena$/ do
  FactoryGirl.create :round, :arena => Arena.last
end

Given /^an approved round exists created by another user$/ do
  FactoryGirl.create :round, :approved => true
end