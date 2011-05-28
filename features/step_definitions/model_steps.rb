Given /^an? #{capture_model} exists created by another user$/ do |model|
  create_model(model)
end

Given /^an? #{capture_model} exists created by "([^"]*)"$/ do |model, user|
  create_model(model, :user => model!("user: \"#{user}\""))
end

When /^I delete the #{capture_model}$/ do |model|
  capitalized_model = model.capitalize!
  click_link "Delete #{capitalized_model}"
end

Given /^an? #{capture_model} exists(?: with #{capture_fields}) created by "([^"]*)"$/ do |model, fields, user|
  create_model(model, parse_fields(fields).merge(:user => model!("user: \"#{user}\"")))
end