class Jarmandy::TeamsController < Jarmandy::BaseController
  def index
    if !params[:q].blank?
      @source = 'Search results'
      @teams = Team.search(params[:q]).order(created_at: :desc)
    elsif params[:only] == 'weird'
      @source = 'Weird teams'
      @teams = Team.where(user_id: nil).order(created_at: :desc)
    else
      @source = 'New teams'
      @teams = Team.order(created_at: :desc)
    end
  end

  def show
    @team = Team.find params[:id]
  end

  def kick
    @team = Team.find params[:id]
    @player = @team.members.find params[:player_id]
    if @player.nil?
      flash[:error] = "that player isn't on this team"
      return redirect_to jarmandy_team_path @team.id
    end

    if @player == @team.user
      flash[:error] = "don't kick th ecaptain, ass"
      return redirect_to jarmandy_team_path @team.id
    end

    @player.update_attribute :team_id, nil
    
    flash[:success] = "gone"
    redirect_to jarmandy_team_path @team.id
  end
end
