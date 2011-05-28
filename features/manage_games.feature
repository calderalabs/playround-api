@games
Feature: Manage Games
  In order to play with my favorite game
  As a user
  I want to manage games

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I go to the home page

  Scenario: Create Game
    When I click the "Games" link
    And I click the "New Game" link
    And I fill in "Name" with "DotA"
    And I fill in "Description" with "An awesome game."
    And I press "Create Game"
    Then I should see "Game was successfully created"
    And I should be on the page for that game

  Scenario: Read Game Details
    Given a game exists
    When I click the "Games" link
    And I click the "Show" link
    Then I should see the details of that game

  Scenario: Update Game
    Given a game exists created by "Matteo"
    When I click the "Games" link
    And I click the "Show" link
    And I click the "Edit" link
    And I fill in "Name" with "Risk!"
    And I press "Update Game"
    Then I should be on the page for that game
    And I should see "Game was successfully updated."
    And I should see "Risk!"

  Scenario: Destroy Game
    Given a game exists with name: "DotA" created by "Matteo"
    When I click the "Games" link
    And I click the "Destroy" link
    Then I should not see "DotA"
    And I should be on the games page