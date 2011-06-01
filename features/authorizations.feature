@authorizations
Feature: Authorizations
  In order to avoid that other users edit what I created
  As a user who created things
  I want to prevent others from editing them

  Background:
    Given a user "Matteo" exists with email: "matteodepalo@mac.com", password: "solidus"
    And I have logged in with email: "matteodepalo@mac.com", password: "solidus"
    And a user "Eugenio" exists

  Scenario Outline: Can Only Read Round, Games and Arenas That You Don't Own
    Given a <model> exists created by "Eugenio"
    And I go to the page for that <model>
    Then I should see the details of that <model>
    And I should not see "Destroy"
    And I should not see "Edit"

    Examples:
      | model |
      | round |
      | arena |
      | game  |

  Scenario: Can Only Read Profiles That You Don't Own
    Given I go to the page for that user
    Then I should see the details of that user
    And I should not see "Edit"