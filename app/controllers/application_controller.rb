class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def require_logged_in
    return true if current_user
    reset_session
    flash[:error] = "You're not logged in."
    redirect_to root_path
  end

  def require_logged_out
    return true unless current_user
    flash[:error] = "You're already logged in."
    redirect_to dashboard_path
  end

  def current_user
    @current_user ||= User.find session[:user_id] rescue nil
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = @current_user.id
  end

  def analytics_flash(*args)
    flash[:analytics] ||= []
    flash[:analytics] << args
  end
end
