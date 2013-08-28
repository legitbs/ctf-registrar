require 'test_helper'

class ScoreboardControllerTest < ActionController::TestCase
  test "should get index" do
    @user = FactoryGirl.create :team_member
    session[:user_id] = @user.id
    be_during_game
    get :index
    assert_response :success
  end

end
