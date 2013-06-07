class PickerController < ApplicationController
  before_filter :require_hot_team

  def choice
    @leaderboard = Team.for_scoreboard current_team
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_picker current_team
  end
end
