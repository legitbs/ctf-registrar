class DashboardController < ApplicationController
  before_filter :require_logged_in

  helper_method :team

  def index
    unless current_user.participant?
      @new_team = current_user.build_team
      @new_membership = Membership.new
    end
  end

  private
  def team
    @team ||= current_user.team
  end
end
