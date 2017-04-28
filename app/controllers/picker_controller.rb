class PickerController < ApplicationController
  before_filter :require_hot_team
  before_filter :require_during_game

  layout 'scoreboard'

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

    @challenge.transaction do
      @challenge.unlock!
      current_team.hot = false
      current_team.save
    end

    message = { kind: 'picked',
                user: current_user,
                team: current_team,
                challenge: @challenge
              }
    SlackbotJob.perform_later message
    PushbulletJob.perform_later message
    PushoverJob.perform_later message

    redirect_to scoreboard_path
  end
end
