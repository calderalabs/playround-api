When /^I delete the #{capture_model}$/ do |model|
  capitalized_model = model.capitalize!
  click_link "Delete #{capitalized_model}"
end

Given /^a #{capture_model} exists with name: "([^"]*)", created by the user "(\w+)"$/ do |model, name, user|
  fields = { :name => name, :user => model!("user: \"#{user}\"")}
  create_model(model, fields)
end