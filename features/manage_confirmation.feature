@confirmation
Feature: Confirmation
  In order to notify subscribers that the round is actually taking place
  As a round organizer
  I want to be able to confirm the round
  
  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And I created a round in the past
    And I go to the home page
    
    Scenario: Confirm the round
      When I go to the page for that round
      And I press "Confirm"
      Then show me the page
    
    
  
  
  

  
