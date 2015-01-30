class UsersController < ApplicationController
  before_filter :require_logged_out
  before_filter :require_before_or_during_game
  
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]

    if @user.save
      flash[:success] = "You've registered!"
      analytics_flash '_trackEvent', 'Users', 'signup'
      UserMailer.welcome_email(@user).deliver_later
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

    analytics_flash '_trackEvent', 'Users', 'login'
    return redirect_to dashboard_path
  end
end
