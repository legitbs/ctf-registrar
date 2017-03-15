require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  context 'when logged in' do
    setup do
      @user = FactoryGirl.create :user
      session[:user_id] = @user.id
      @team = FactoryGirl.create :team
    end

    context 'without a team' do
      context 'POST to create' do
        setup do
          post :create, params: { membership: {name: @team.name, password: 'kenny'} }
        end

        should redirect_to('the dashboard'){ dashboard_path }
        should "put the user on a team" do
          assert_equal @team, @user.reload.team
        end
      end
    end
  end
end
