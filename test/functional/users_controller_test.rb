require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context 'the users controller' do
    context 'on successful create' do
      setup do
        be_before_game
        @user_attrs = FactoryGirl.attributes_for :user_params_valid
        @old_users = User.all
        post :create, user: @user_attrs
      end
      should redirect_to('the dashboard'){ dashboard_path }
      should set_session(:user_id)
      should 'send a confirmation'
    end
  end
end
