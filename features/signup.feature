Feature: Signup
  In order to compete
  As a user
  I want to be able to sign up myself and a team

Scenario: Signup
  Given I am on the homepage
  When I complete the initial user form
  And I complete the secondary user form
  Then I should be logged in
  And I should have a user confirmation email

Scenario: Team signup
  Given I am signed in
  When I complete the team creation form
  Then I should be associated with a team
  And I should have a team confirmation email