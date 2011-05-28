@rounds
Feature: Manage Rounds
  In order to organize matches with others
  As a user
  I want to create rounds

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I go to the home page

  Scenario: Create Round
    Given an arena exists
    And a game exists
    When I click the "Rounds" link
    And I click the "New Round" link
    And I fill in "Name" with "DotA Party"
    And I fill in "Max people" with "20"
    And I fill in "Min people" with "10"
    And I select that game from "Game"
    And I select that arena from "Arena"
    And I press "Create Round"
    Then I should see "Round was successfully created"
    And I should be on the page for that round
    And I should see the details of that round

  Scenario: Read Round Details
    Given a round exists
    When I click the "Rounds" link
    And I click the "Show" link
    Then I should see the details of that round

  Scenario: Update Round
    Given a round exists created by "Matteo"
    When I click the "Rounds" link
    And I click the "Show" link
    And I click the "Edit" link
    And I fill in "Name" with "Risk! Party"
    And I press "Update Round"
    Then I should be on the page for that round
    And I should see "Round was successfully updated."
    And I should see "Risk! Party"

  Scenario: Destroy Round
    Given a round exists with name: "DotA Party" created by "Matteo"
    When I click the "Rounds" link
    And I click the "Destroy" link
    Then I should not see "DotA Party"
    And I should be on the rounds page