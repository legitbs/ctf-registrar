class TeamsController < ApplicationController
  before_filter :require_logged_in
  before_filter :require_team, except: [:new, :create]

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = current_user.build_owned_team(params[:team])

    if @team.save
      current_user.team_id = @team.id
      current_user.save!
      redirect_to dashboard_path
    else
      render action: "new"
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
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
