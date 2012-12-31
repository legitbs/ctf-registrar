require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context 'the users controller' do
    should 'show a form on incomplete (home screen) create'
    should 'redirect to the dashboard on successful create'
  end
end
