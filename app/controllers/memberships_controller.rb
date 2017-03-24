class MembershipsController < ApplicationController
  before_action :require_no_team

  def create
    m = Membership.new params[:membership]

    current_user.team = m.team
    if m.team && current_user.save
      TeamMailer.new_member_email(current_user).deliver_later
      SlackbotJob.perform_later(kind: 'team_join',
                                team: m.team,
                                user: current_user)
      RedisJob.perform_later(kind: 'team_join',
                             team: m.team,
                             user: current_user)
      cheevo 'syn-ack'
      analytics_flash '_trackEvent', 'Teams', 'join'
      flash[:notice] = "Joined the team \"#{m.team.name}\"."
    else
      flash[:error] = "Couldn't join the team."
    end
    redirect_to dashboard_path
  end
end
