class ScoreboardController < ApplicationController
  def index
    @leaderboard = Team.for_scoreboard Team.find(7)
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_scoreboard Team.first

    @challenge = Challenge.find 12
  end
end
