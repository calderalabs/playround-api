Then /^I should be able to create a #{capture_model} with name: "([^"]*)", max people: "([^"]*)", min people: "([^"]*)", existing #{capture_model} and #{capture_model}$/ do |model, name, max, min, game, arena|
  click_link "New Round"
  fill_in "Name", :with => name
  fill_in "Max people", :with => max
  fill_in "Min people", :with => min
  select model!(game).name, :from => "Game"
  select model!(arena).name, :from => "Arena"
  click_button "Create Round"
end

When /^I change the ([^"]*) of the round to "([^"]*)"$/ do |field, value|
  field = field.capitalize!
  fill_in field, :with => value
end