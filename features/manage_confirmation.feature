@confirmation
Feature: Confirmation
  In order to notify subscribers that the round is actually taking place
  As a round organizer
  I want to be able to confirm the round
  
  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And a round exists created by "Matteo"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I go to the home page
    
    Scenario: Confirm the round
      Given the current time is between the deadline and the date
      When I go to that round's page
      Then show me the page
    
    
    
    
  
  
  

  
