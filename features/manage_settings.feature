@settings
Feature: Manage settings
  In order to be able to personalize what other people can see about me
  As a user
  I want to manage my profile settings
  
  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And a user "Eugenio" exists with email: "eugeniodepalo@gmail.com", password: "solidus"
    
  Scenario: Default email invisibility
    When I go to that user's page
    Then I should not see "eugeniodepalo@gmail.com"
  
  Scenario: Make the email visible
    Given I click "Sign out"
    And I have logged in with email: "eugeniodepalo@gmail.com", password: "solidus"
    When I click "eugeniodepalo"
    And I click "Edit"
    And I check "Show email"
    And I press "Update Profile"
    And I click "Sign out"
    Given I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    When I press "No, thanks" inside the tour dialog
    And I go to user "Eugenio"'s page
    Then I should see "eugeniodepalo@gmail.com"
  
  
  
  
  

  
