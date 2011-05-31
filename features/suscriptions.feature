@subscriptions
Feature: Subscriptions
  In order to participate in and leave rounds
  As a user
  I want to subscribe and unsubscribe to rounds

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And a round exists created by another user

  Scenario: Subscribe to a round
    Given I go to the page for that round
    When I click the "Subscribe" link
    Then I should see "You successfully subscribed to this round."
    And I should see my email among the list of participants

  Scenario: Unsubscribe to a round
    Given I am subscribed to that round
    And I go to the page for that round
    When I click the "Unsubscribe" link
    Then I should see "You are no longer subscribed to this round."
    And I should not see my email among the list of participants