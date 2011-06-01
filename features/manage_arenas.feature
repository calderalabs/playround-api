@arenas
Feature: Manage Arenas
  In order to manage places to play in
  As a owner of a public or private place
  I want to manage arenas

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I go to the home page

  Scenario: Create Arena
    When I click the "Arenas" link
    And I click the "New Arena" link
    And I fill in "Name" with "Depalo's House"
    And I fill in "Description" with "An awesome place to play."
    And I press "Create Arena"
    Then I should see "Arena was successfully created"
    And I should be on the page for that arena

  Scenario: Read Arena Details
    Given an arena exists
    When I click the "Arenas" link
    And I click the "Show" link
    Then I should see the details of that arena

  Scenario: Update Arena
    Given an arena exists created by "Matteo"
    When I click the "Arenas" link
    And I click the "Show" link
    And I click the "Edit" link
    And I fill in "Name" with "Tea Room"
    And I press "Update Arena"
    Then I should be on the page for that arena
    And I should see "Arena was successfully updated."
    And I should see "Tea Room"

  Scenario: Destroy Arena
    Given an arena exists with name: "Depalo's House" created by "Matteo"
    When I click the "Arenas" link
    And I click the "Destroy" link
    And I click the confirmation button
    Then I should not see "Depalo's House"
    And I should be on the arenas page