class ResetsController < ApplicationController
  before_filter :require_logged_in, only: %i{ index destroy }
  before_filter :require_logged_out, only: %i{ new create show update }
  before_filter :require_valid_token, only: %i{ show update }
  def index
    @resets = current_user.resets
  end

  def new
  end

  def create
    recaptcha_okay = verify_recaptcha
    user = User.find_by_email params[:email]
    unless recaptcha_okay and user
      flash[:error] = "Couldn't reset password."
      return redirect_to new_reset_path
    end

    @reset = user.resets.create
    ResetMailer.reset_email(@reset).deliver_later
    flash[:success] = "Reset email sent."
    return redirect_to root_path
  end

  def destroy
    @reset = current_user.resets.find params[:id]
    @reset.disavow!
    return redirect_to resets_path
  end

  def update
    @user = @reset.user
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    success = false

    @user.transaction do |u|
      success = @reset.consume! && @user.save

      fail ActiveRecord::Rollback unless success
    end

    if success
      cheevo 'Forgetful' if during_game?
      ResetMailer.did_reset_email(@reset).deliver
      flash[:success] = "Password reset successfully."
      return redirect_to dashboard_path
    end

    flash[:error] = "Failed to reset password."
    redirect_to root_path
  end

  private
  def require_valid_token
    @reset = Reset.find_by_token params[:id]
    return true if @reset

    flash[:error] = "Couldn't find that reset token."
    return redirect_to root_path
  end
end
