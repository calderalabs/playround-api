@dashboard
Feature: Dashboard
  In order to have a list of the rounds that will take place in my public arenas
  As a public arena owner
  I want a dashboard to approve and reject rounds created by other users
  
  Background:
    Given a user exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I go to the home page
    And a public arena exists created by that user
    And a user created a round in that arena
    When I click the "Dashboard" link
    
  Scenario: Approve a round
    Then I should see that round listed
    When I press "Approve"
    Then I should see "Round was successfully approved"
    And I should not see that round listed
    
  Scenario: Reject a round
    Then I should see that round listed
    When I press "Reject"
    Then I should see "Round was successfully rejected"
    And I should not see that round listed
  
  
  
  
  
  

  
