Feature: Sign Up
	In order to get access to Playround
	As a guest
	I want to sign up

	Scenario: Sign Up
		Given I'm a guest
		When I go to the home page
		Then I should be able to sign up with email: "matteodepalo@mac.com", password: "solidus"
		Then I should be on the home page
		And I should see "You are now signed up"