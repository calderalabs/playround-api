@signinout
Feature: Access
  In order to get access to or leave Playround
  As a registered user
  I want to sign in or sign out

  Background:
    Given a user exists with email: "matteodepalo@mac.com", password: "solidus"

  Scenario: Sign In
    When I go to the home page
    And I click the "Sign in!" link
    Then I should be able to sign in with email: "matteodepalo@mac.com", password: "solidus"
    Then I should be on the rounds page

  Scenario: Sign Out
    Given I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    When I go to the home page
    Then I should be able to sign out