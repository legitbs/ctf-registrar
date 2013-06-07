class PickerController < ApplicationController
  before_filter :require_hot_team

  def choice
    @leaderboard = Team.for_scoreboard current_team
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_picker current_team
  end

  def pick
    @challenges = Challenge.for_picker current_team
    @challenge = Challenge.find params[:id]

    found = @challenges.flatten.detect do |r|
      r['challenge_id'].to_i == @challenge.id
    end
    return redirect_to choice_path if found.nil?
    return redirect_to choice_path unless found['class'] == 'burning'

    @challenge.unlock!

    redirect_to scoreboard_path
  end
end
