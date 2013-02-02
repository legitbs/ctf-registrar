class MembershipsController < ApplicationController
  before_filter :require_no_team

  def create
    m = Membership.new params[:membership]

    current_user.team = m.team
    if m.team && current_user.save
      flash[:notice] = "Joined the team \"#{m.team.name}\"."
    else
      flash[:error] = "Couldn't join the team."
    end
    redirect_to dashboard_path
  end

  private
  def require_no_team
    return true unless current_user.team
    flash[:error] = "You're already on a team."
    redirect_to dashboard_path
  end
end
