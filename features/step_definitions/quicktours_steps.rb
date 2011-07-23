When /^I press "([^"]*)" inside the tour dialog$/ do |button|
  find(:xpath, "//a[@class='guider_button' and contains(text(),\"#{button}\")]").click
end

Then /^I should not see the tour dialog$/ do
  page.should_not have_css('.guider', :visible => true)
end
