class Jarmandy::TeamsController < Jarmandy::BaseController
  def index
    if !params[:q].blank?
      @source = 'Search results'
      @teams = Team.search(params[:q]).order(created_at: :desc)
    elsif params[:only] == 'weird'
      @source = 'Weird teams'
      @teams = Team.where(user_id: nil).order(created_at: :desc)
    elsif params[:only] == 'scoreboard'
      @source = 'Good teams, no particular order'
      @teams = Team.where(id: Team.anonymous_scoreboard.map{ |row| row['team_id'] })
    elsif params[:only] == 'olde'
      @source = 'All teams, oldest first'
      @teams = Team.order(created_at: :asc)
    else
      @source = 'New teams'
      @teams = Team.order(created_at: :desc)
    end

    if @teams.count > PER_PAGE
      page = (params[:page] || 1).to_i
      offset = (page - 1) * PER_PAGE
      @paginated_teams = @teams.offset(offset).limit(PER_PAGE)
      @show_pagination = true
      @current_page = page
      @pages = (@teams.count / PER_PAGE) + 1
    else
      @paginated_teams = @teams
      @show_pagination = false
    end

  rescue ActiveRecord::StatementInvalid => @error
    return render 'query_error'
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
