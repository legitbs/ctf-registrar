require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  context 'when logged in' do
    setup do
      @user = FactoryGirl.create :user
      session[:user_id] = @user.id
    end

    context 'without a team' do
      context 'GET to index' do
        setup do
          get :index
        end

        should respond_with :success
        should 'render team create and join forms' do
          assert_tag tag: 'form', attributes: {id: 'new_team'}
          assert_tag tag: 'form', attributes: {id: 'new_membership'}
        end
      end
    end
  end
end
