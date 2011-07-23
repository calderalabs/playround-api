@profile
Feature: Manage Profile
  In order to edit my personal informations
  As a user
  I want to edit my profile

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I go to the home page

  Scenario: Read Profile
    When I click the "matteodepalo" link
    Then I should be on the page for that user
    And I should see "matteodepalo"
    And I should see an empty picture

  Scenario: Edit Profile
    When I click the "matteodepalo" link
    And I click the "Edit" link
    And I set my avatar
    And I fill in "Display name" with "nemesys"
    And I fill in "Real name" with "Matteo Depalo"
    And I press "Update Profile"
    Then I should see "Your profile was successfully updated."
    And I should see my avatar
    And I should see "nemesys"
    And I should see "Matteo Depalo"