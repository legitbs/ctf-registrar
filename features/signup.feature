Feature: Signup
  In order to compete
  As a user
  I want to be able to sign up myself and a team

Scenario: Signup
  Given I am on the homepage
  When I complete the initial user form
  And I complete the secondary user form
  Then I should be logged in
  And I should have a user creation confirmation email

Scenario: Team creation
  Given I am signed in
  When I complete the team creation form
  Then I should own a team
  And I should have a team creation confirmation email

Scenario: Team joining
  Given I am signed in
  When I complete the team join form
  Then I should be on a team
  And I should have a team joining confirmation email
  And the owner should have a team joining notification email
