Feature: Manage Round
	In order to use playround
	As a logged in user
	I want to manage rounds

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I've logged in with email: "matteodepalo@mac.com", password: "solidus"

	Scenario: Create Round
		Given an arena exists with name: "Casa Depalo"
		And a game exists with name: "DotA"
		When I go to the rounds page
		Then I should be able to create a round with name: "DotA Party", max people: "20", min people: "10", existing game and arena
    Then I should see "Round was successfully created"
		And I should see "DotA Party"
		And I should see "20"
		And I should see "10"

  Scenario: Read Round
    Given a round exists with name: "DotA Party"
    When I go to the rounds page
    And I click the "Show" link
    Then I should see "DotA Party"

  Scenario: Update Round
    Given a round exists with name: "DotA Party", created by the user "Matteo"
    When I go to the rounds page
    And I click the "Show" link
    And I click the "Edit" link
    And I change the name of the round to "DotA Parties"
    And I press "Update Round"
    Then I should be on the show page for that round
    And I should see "Round was successfully updated."
    And I should see "DotA Parties"

  Scenario: Destroy Round
    And a round exists with name: "DotA Party", created by the user "Matteo"
    When I go to the rounds page
    And I click the "Destroy" link
    Then I should not see "DotA Party"
    And I should be on the rounds page