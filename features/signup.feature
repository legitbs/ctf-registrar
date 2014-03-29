Feature: Signup
  In order to compete
  As a user
  I want to be able to sign up myself and a team

Scenario: Signup
  Given I am on the homepage
  When I visit the new user page
  And I complete the new user form
  Then I should be logged in
  And I should have a "Welcome" email

Scenario: Team creation
  Given I am signed in
  When I complete the team creation form
  Then I should own a team
  And I should have a "Registered a team" email
  And my team should have the "syn" achievement

Scenario: Team joining
  Given I am signed in
  When I complete the team join form
  Then I should be on a team
  And I should have a "Joined a team" email
  And my team should have the "syn-ack" achievement
