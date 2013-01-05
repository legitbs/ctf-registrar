require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context 'the users controller' do
    should 'show a form on incomplete (home screen) create' do
      @user_attrs = FactoryGirl.attributes_for :user
      @user_attrs.delete :email

      post :create, user: @user_attrs

      assert_template 'new'
      assert_tag tag: 'form', attributes: {method: 'post'}
    end

    context 'on successful create' do
      should redirect_to('the dashbaord'){ dashboard_path }
      should 'send a confirmation'
    end
  end
end
