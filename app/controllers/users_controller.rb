class UsersController < ApplicationController
  before_filter :require_logged_out
  
  def create
    if params[:commit] == 'Log In'
      return try_login
    end
    @user = User.new params[:user]
    if @user.save
      flash[:success] = "You've registered!"
      self.current_user = @user
      return redirect_to dashboard_path
    end

    @password_stash = params[:user][:password]

    render action: 'new'
  end

  private
  def try_login
    @user = User.where(username: params[:user][:username]).first
    unless @user && @user.authenticate(params[:user][:password])
      flash[:error] = "Couldn't log in."
      return redirect_to root_path
    end

    self.current_user = @user
    return redirect_to dashboard_path
  end
end
