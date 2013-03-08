class TeamsController < ApplicationController
  before_filter :require_logged_in
  before_filter :require_team, except: [:new, :create]

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = current_user.build_owned_team(params[:team])

    if @team.save
      TeamMailer.new_team_email(@team).deliver
      current_user.team_id = @team.id
      current_user.save!

      analytics_flash '_trackEvent', 'Teams', 'create'
      redirect_to dashboard_path
    else
      render action: "new"
    end
  end

  private
  def team
    current_user.owned_team
  end

  def require_team
    return true if team
    flash[:error] = "You don't own a team."
    redirect_to dashboard_path
  end
end
