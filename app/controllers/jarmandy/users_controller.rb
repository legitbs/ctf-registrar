class Jarmandy::UsersController < Jarmandy::BaseController
  def index
    if !params[:q].blank?
      @source = 'Search results'
      @users = User.search(params[:q]).order(created_at: :desc)
    elsif params[:only] == 'orphans'
      @source = 'Lonely users'
      @users = User.where(team_id: nil).order(created_at: :desc)
    else
      @source = 'Recent signups'
      @users = User.order(created_at: :desc)
    end
  rescue PG::SyntaxError, PG::Error => @error
    render view: 'query_error'
  end

  def show
    @user = User.find params[:id]
  end
end