Given /^I created a round in the past$/ do
  now = Time.now
  Time.stub(:now).and_return(now - 1.month)
  Factory :round, :deadline => Time.now + 1.day, :date => Time.now + 2.months, :user => User.last
  Time.unstub(:now)
end