class Jarmandy::ObservationsController < Jarmandy::BaseController
  before_action :set_observation, only: [:show, :edit, :update, :destroy]

  # GET /observations
  # GET /observations.json
  def index
    @observations = scope.all
  end

  # GET /observations/1
  # GET /observations/1.json
  def show
  end

  # GET /observations/new
  def new
    @observation = scope.new
  end

  # GET /observations/1/edit
  def edit
  end

  # POST /observations
  # POST /observations.json
  def create
    @observation = scope.new(observation_params)

    respond_to do |format|
      if @observation.save
        format.html { redirect_to @observation, notice: 'Observation was successfully created.' }
        format.json { render :show, status: :created, location: @observation }
      else
        format.html { render :new }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def scope
    return @scope if defined? @scope
    if params[:challenge_id]
      chall = Challenge.find(params[:challenge_id])
      @title = "Observations of challenge #{chall.name}"
      @filtered = :challenge
      @scope = chall.observations
    elsif params[:team_id]
      team = Team.find(params[:team_id])
      @title = "Observations of team #{team.name}"
      @filtered = :team
      @scope = team.observations
    else
      @title = "All observations"
      @filtered = false
      @scope = Observation.limit(25)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
    def set_observation
      @observation = scope.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def observation_params
      params.require(:observation).permit(:team_id, :challenge_id, :user_id)
    end
end
