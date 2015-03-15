class UsersController < ApplicationController
  before_filter :require_logged_out
  before_filter :require_before_or_during_game

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "You've registered!"
      analytics_flash '_trackEvent', 'Users', 'signup'
      UserMailer.welcome_email(@user).deliver_later
      self.current_user = @user
      return redirect_to dashboard_path
    end

    @password_stash = user_params[:password]

    render action: 'new'
  end

  private
  def user_params
    params.
      require(:user).
      permit(*%i{ username
               password password_confirmation
               email email_confirmation
               visa
             })
  end
end
