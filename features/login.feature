Feature: Login
  In order to check on my team
  As a user
  I want to be able to log in

  Scenario: Login
    Given I am on the homepage
    And I have an existing account
    When I complete the login form
    Then I should be logged in

  Scenario: Lost Password
    Given I am on the homepage
    And I have an existing account
    When I complete the lost password flow
    Then I should have a lost password email
