Given /^I select "([^"]*)" as my location$/ do |location|
  click_link('change-location')
  field = find('#location')
  field.set(location)
  field.native.send_key(:enter)
end
