Given /^I am on the homepage$/ do
  visit '/'
end

When /^I complete the initial user form$/ do
  @user_attrs = FactoryGirl.attributes_for :user

  fill_in 'user_username', with: @user_attrs[:username]
  fill_in 'user_password', with: @user_attrs[:password]
  click_on 'Create Account'
end

When /^I complete the secondary user form$/ do
  fill_in 'user_password', with: @user_attrs[:password]
  fill_in 'user_email', with: @user_attrs[:email]
  fill_in 'user_email_confirmation', with: @user_attrs[:email]

  click_on 'Create Account'
end

