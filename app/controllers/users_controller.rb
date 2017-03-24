class UsersController < ApplicationController
  before_action :require_logged_out
  before_action :require_before_or_during_game

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    begin
      @user.save
    rescue ActiveRecord::RecordNotUnique
    end

    unless @user.persisted?
      @password_stash = user_params[:password]

      return render action: 'new'
    end

    flash[:success] = "You've registered!"
    analytics_flash '_trackEvent', 'Users', 'signup'
    UserMailer.welcome_email(@user).deliver_later
    SlackbotJob.perform_later(kind: 'user_create',
                              user: @user)
    RedisJob.perform_later(kind: 'user_create',
                           user: @user)
    self.current_user = @user
    redirect_to dashboard_path
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
