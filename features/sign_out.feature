Feature: Sign Out
	In order to leave Playround
	As a logged in user
	I want to sign out

	Scenario: Sign Out
		Given a user exists with email: "matteodepalo@mac.com", password: "solidus"
		And I've logged in with email: "matteodepalo@mac.com", password: "solidus"
		When I go to the home page
		Then I should be able to sign out
		And I should see "Signed out"