require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  context 'while logged in' do
    setup do
      @team = FactoryGirl.build :team
      session[:user_id] = @team.user.id
    end
  end
end
