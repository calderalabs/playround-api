@signup
Feature: Sign Up
	In order to get access to Playround
	As a guest
	I want to sign up

	Scenario: Sign Up From Homepage
		Given I'm a guest
		When I go to the home page
		Then I should be able to sign up with email: "matteodepalo@mac.com", password: "solidus"
		Then I should be on the rounds page
		And I should see "Welcome to Playround!"
		
	Scenario: Sign Up From Signup Page
	  Given I'm a guest
	  When I go to the sign up page
	  Then I should be able to sign up with email: "matteodepalo@mac.com", password: "solidus"
	  Then I should be on the rounds page
	  And I should see "Welcome to Playround!"
	
	
	