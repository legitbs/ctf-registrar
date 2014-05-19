class AchievementsController < ApplicationController
  before_filter :require_on_team, only: :index
  helper_method :awards

  def index
    @team = current_team
  end

  def show
    @team = Team.find(params[:id])
    render 'index'
  end

  private

  def awards
    @awards ||= @team.awards.order(created_at: :asc)
  end
end
