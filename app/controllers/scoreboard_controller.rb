class ScoreboardController < ApplicationController
  def index
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_scoreboard(Team.first)
  end
end
