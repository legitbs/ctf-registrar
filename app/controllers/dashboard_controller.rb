class DashboardController < ApplicationController
  before_filter :require_logged_in
  def index
    unless current_user.participant?
      @new_team = current_user.build_team
      @new_membership = Membership.new
    end
  end
end
