require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  context 'while logged in' do
    setup do
      @user = FactoryGirl.create :user
      session[:user_id] = @user.id
    end

    context 'without a team' do
      # context 'GET to show' do
      #   setup do
      #     get :show
      #   end

      #   should redirect_to('dashboard'){ dashboard_path }
      # end
    end
  end
end
