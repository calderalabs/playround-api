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
    Given an arena exists with name: "Depalo's House"
    And a game exists with name: "DotA"
    When I click the "Rounds" link
    And I click the "Start a new round" link
    And I fill in "Maximum people" with "20"
    And I fill in "Minimum people" with "10"
    And I fill in "Game" with "DotA"
    And I select "DotA" from the list
    And I fill in "Arena" with "Depalo's House"
    And I select "Depalo's House" from the list
    And I press "Create Round"
    Then I should see "Round was successfully created"
    And I should be on the page for that round
    And I should see the details of that round

  Scenario: Read Round Details
    Given a round exists
    And I select "Siena, Italy" as my location
    When I click the "Rounds" link
    And I click the "Show" link
    Then I should see the details of that round

  Scenario: Update Round
    Given a round exists created by "Matteo"
    And I select "Siena, Italy" as my location
    When I click the "Rounds" link
    And I click the "Show" link
    And I click the "Edit" link
    And I press "Update Round"
    Then I should be on the page for that round
    And I should see "Round was successfully updated."

  Scenario: Destroy Round
    Given a game: "DotA" exists with name: "DotA"
    Given a round exists with game: game "DotA" created by "Matteo"
    And I select "Siena, Italy" as my location
    When I click the "Rounds" link
    And I click the "Show" link
    And I click the "Delete" link
    And I click the confirmation button
    Then I should not see "DotA"
    And I should be on the rounds page