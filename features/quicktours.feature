@quicktour
Feature: Quicktour
  In order to be better introduced to the usage of Playround
  As a user who just signed up
  I want to go through a guided tour
  
  Background:
    Given I'm a guest
	  When I go to the home page
	  Then I should be able to sign up with email: "matteodepalo@mac.com", password: "solidus"
    And I should see "Welcome"
    
  Scenario: Follow the guided tour
    When I press "Next" inside the tour dialog
    Then I should see "Change your location"
    When I press "Next" inside the tour dialog
    Then I should see "Change profile"
    When I press "Next" inside the tour dialog
    Then I should see "What are rounds"
    When I press "Next" inside the tour dialog
    Then I should see "What are arenas"
    When I press "Close" inside the tour dialog
    Then I should not see the tour dialog
    
  Scenario: Hide the guided tour
    When I press "No, thanks" inside the tour dialog
    Then I should not see the tour dialog
    When I refresh the page
    Then I should not see the tour dialog
    
  Scenario: Resume the guided tour
    When I press "Next" inside the tour dialog
    Then I should see "Change your location"
    When I refresh the page
    Then I should see "Change your location"