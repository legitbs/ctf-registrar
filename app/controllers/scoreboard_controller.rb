class ScoreboardController < ApplicationController
  def index
    @leaderboard = Team.for_scoreboard Team.find(7)
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_scoreboard Team.first

    @challenge = Challenge.find 12

    respond_to do |f|
      f.html
      f.json {
        render json: {
          leaderboard: @leaderboard,
          challenges: @challenges
        }
      }
    end
  end

  def challenge
    @challenge = Challenge.find params[:id]

    respond_to do |f|
      f.html
      f.json { render json: f }
    end
  end
end
