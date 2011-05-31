@comments
Feature: Manage Comments
  In order to comment the rounds I'm participating in
  As a round participant
  I want to be able to manage comments

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I go to the home page
    And a round exists

  Scenario: Create Comment
    Given I am on the page for that round
    And I fill in "Text" with "This round is amazing"
    And I press "Add Comment"
    Then I should see "Comment was successfully added"
    And I should be on the page for that round
    And I should see "This round is amazing"

  Scenario: Read Comment
    Given a comment for that round exists with text: "This round is amazing" created by "Matteo"
    When I go to the page for that round
    Then I should see "This round is amazing"
    And I should see "Matteo"'s email in the comments box

  Scenario: Destroy Comment
    Given a comment for that round exists with text: "This round is amazing" created by "Matteo"
    When I go to the page for that round
    When I click the "Destroy" link in the comments box
    And I should not see "This round is amazing"