class ResetsController < ApplicationController
  before_filter :require_logged_in, only: %i{ index destroy }
  before_filter :require_logged_out, only: %i{ new create edit update }
  before_filter :require_valid_token, only: %i{ edit update }
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

    reset = user.resets
  end

  def edit
  end

  private
  def require_valid_token
    @reset = Reset.find_by_token params[:id]
  end
end
