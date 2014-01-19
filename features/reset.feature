Feature: Password Reset
  In order to recover my account
  As a user
  I want to be able to reset my password

  Scenario: Send reset code
    Given I am on the homepage
    And I have an existing account
    When I fill out the lost password form
    Then I should have an "Attempting to reset" email

  Scenario: Use reset code
    Given I have a reset URL
    When I set a new password
    Then I should have a new password
