class ScoreboardController < ApplicationController
  before_filter :require_on_team

  def index
    @leaderboard = Team.for_scoreboard current_team
    @categories = Category.for_scoreboard
    @challenges = Challenge.for_scoreboard current_team

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
    @solution = current_team.solution_for @challenge

    return redirect_to scoreboard_path if @challenge.locked?

    respond_to do |f|
      f.html
      f.json { render json: {category: @challenge.category, challenge: @challenge, solution: @solution} }
    end
  end

  def answer
    @challenge = Challenge.find params[:id]
    @solution = current_team.solution_for @challenge

    return redirect_to scoreboard_path if @challenge.locked?
    return redirect_to scoreboard_path if @solution.created_at

    unless @challenge.correct_answer? params[:answer]
      return redirect_to challenge_path(@challenge.id) 
    end

    @solution.transaction do
      hot = @challenge.solve!
      @solution.save
      if hot
        current_team.hot = true
        current_team.save
        redirect_to 
      end
    end
  end

  private
  def solution
    current_team
  end
end
