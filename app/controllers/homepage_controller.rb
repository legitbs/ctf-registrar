class HomepageController < ApplicationController
  before_filter :require_logged_out

  def index
  end

  def require_logged_out
    return true unless current_user
    redirect_to dashboard_path
  end
end
