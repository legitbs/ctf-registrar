class AchievementsController < ApplicationController
  before_filter :require_on_team

  def index
    @awards = current_team.awards.order(created_at: :asc)
  end
end
