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
end
