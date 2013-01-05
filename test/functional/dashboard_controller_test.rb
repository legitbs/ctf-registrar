require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  context 'when logged in' do
    setup do
      @user = FactoryGirl.create :user
      session[:user_id] = @user.id
    end

    context 'GET to index' do
      setup do
        get :index
      end

      should respond_with :success
    end
  end
end
