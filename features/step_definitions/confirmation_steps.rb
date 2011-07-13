Given /^the current time is between the deadline and the date$/ do
  Time.stub(:now).and_return(Round.last.deadline + 10.minutes)
end