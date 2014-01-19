Given /^I am on the homepage$/ do
  visit '/'
end

Given /^I have an existing account$/ do
  @user = FactoryGirl.create :user
  @user_attrs = @user.attributes
end

When /^I visit the new user page$/ do
  visit '/'
  click_on 'Sign Up'
end

When /^I complete the new user form$/ do
  @user_attrs = FactoryGirl.attributes_for :user

  fill_in 'user_username', with: @user_attrs[:username]
  fill_in 'user_password', with: @user_attrs[:password]
  fill_in 'user_password_confirmation', with: @user_attrs[:password]
  fill_in 'user_email', with: @user_attrs[:email]
  fill_in 'user_email_confirmation', with: @user_attrs[:email]

  click_on 'Create Account'
end

When /^I complete the login form$/ do
  fill_in 'username', with: @user.username
  fill_in 'password', with: @user.password

  click_on 'Log In'
end

Then /^I should be logged in$/ do
  login_expectation = "Logged in as #{@user_attrs[:email]}"
  assert page.has_content?(login_expectation), "Couldn't find #{login_expectation.inspect}"
end

Then /^.+ should have an? "(.*)" email$/ do |subject|
  assert ActionMailer::Base.deliveries.any? do |m|
    m.subject.downcase.include? subject.downcase
  end
end

Given /^I am signed in$/ do
  @user = FactoryGirl.create :user
  visit '/'
  fill_in 'username', with: @user.username
  fill_in 'password', with: @user.password
  click_on 'Log In'
end

When /^I complete the team creation form$/ do
  @team_attrs = FactoryGirl.attributes_for :team
  fill_in 'team_name', with: @team_attrs[:name]
  fill_in 'team_password', with: @team_attrs[:password]
  fill_in 'team_password_confirmation', with: @team_attrs[:password]
  click_on 'Create Team'
end

When /^I fill out the lost password form$/ do
  click_on 'Reset Password'
  fill_in 'email', with: @user.email
  click_on 'Reset Password'
end

Then /^I should own a team$/ do
  team_expectation = "the registered owner of #{@team_attrs[:name]}."
  assert page.has_content?(team_expectation), "Couldn't find #{team_expectation.inspect}"
end

When /^I complete the team join form$/ do
  @team = FactoryGirl.create :team
  fill_in 'membership_name', with: @team.name
  fill_in 'membership_password', with: 'kenny'
  click_on 'Join'
end

Then /^I should be on a team$/ do
  team_expectation = "member of #{@team.name}."
  assert page.has_content?(team_expectation), "Couldn't find #{team_expectation.inspect}"
end
