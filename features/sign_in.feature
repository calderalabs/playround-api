Feature: Sign In
	In order to get access to Playround
	As a registered user
	I want to sign in

	Scenario: Sign In
		Given a user exists with email: "matteodepalo@mac.com", password: "solidus"
		When I go to the home page
		Then I should be able to sign in with email: "matteodepalo@mac.com", password: "solidus"
		Then I should be on the home page
		And I should see "Signed in"