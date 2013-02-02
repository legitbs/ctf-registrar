class TeamMailer < ActionMailer::Base
  default from: 'team@legitbs.net', template_path: 'team_mailer'

  def new_team_email(team)
    @team = team
    @user = team.user
    mail to: @user.email, subject: 'You registered a team for the 2013 CTF Quals'
  end
end
