class Jarmandy::UsersController < Jarmandy::BaseController
  def index
    if !params[:q].blank?
      @source = 'Search results'
      @users = User.search(params[:q]).order(created_at: :desc)
    elsif params[:only] == 'orphans'
      @source = 'Lonely users'
      @users = User.where(team_id: nil).order(created_at: :desc)
    elsif params[:only] == 'olde'
      @source = 'All users, oldest first'
      @users = User.order(created_at: :asc)
    else
      @source = 'Recent signups'
      @users = User.order(created_at: :desc)
    end

    if @users.count > PER_PAGE
      page = (params[:page] || 1).to_i
      offset = (page - 1) * PER_PAGE
      @paginated_users = @users.offset(offset).limit(PER_PAGE)
      @show_pagination = true
      @current_page = page
      @pages = (@users.count / PER_PAGE) + 1
    else
      @paginated_users = @users
      @show_pagination = false
    end

  rescue ActiveRecord::StatementInvalid => @error
    return render 'query_error'
  end

  def show
    @user = User.find params[:id]
  end

  def become
    @user = User.find params[:id]

    SlackbotJob.perform_later(kind: 'admin_becoming',
                              user_id: @user.id,
                              admin_id: current_user.id)
    if @user.team
      Notice.create(team: @user.team,
                    body: <<-MESG)
An administrator is impersonating #{@user.username} on your team.
MESG
    end

    session[:user_id] = @user.id
    redirect_to dashboard_path
  end
end
