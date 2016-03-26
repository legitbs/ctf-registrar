class TeamsController < ApplicationController
  before_filter :require_logged_in
  before_filter :require_team, except: [:new, :create]
  before_filter :require_no_team, only: %i{new create}
  before_filter :require_before_or_during_game

  helper_method :team

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
    @team = current_user.build_owned_team(team_params)

    begin
      @team.transaction do
        @team.save!
        current_user.team_id = @team.id
        current_user.save!
      end
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique
    end

    if @team.persisted?
      # email them or don't
      TeamMailer.new_team_email(@team).deliver_later rescue nil
      SlackbotJob.perform_later(kind: 'team_create',
                                team: @team)

      cheevo('syn')

      analytics_flash '_trackEvent', 'Teams', 'create'
      flash[:success] = "Created and captained team"
      redirect_to dashboard_path
    else
      render action: "new"
    end
  end

  def update
    if team.update_attributes team_params
      flash[:success] = "Updated team"
      return redirect_to dashboard_path
    end

    render action: 'edit'
  end

  private
  def team
    @team ||= current_user.owned_team
  end

  def require_team
    return true if team
    flash[:error] = "You don't own a team."
    redirect_to dashboard_path
  end

  def team_params
    params.
      require(:team).
      permit(:name, :password, :password_confirmation, :fun, :logo)
  end
end
