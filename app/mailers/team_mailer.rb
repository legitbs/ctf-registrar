class TeamMailer < ActionMailer::Base
  default from: 'team@legitbs.net', template_path: 'team_mailer'

  def new_team_email(team)
    @team = team
    @user = team.user

    mail to: @user.email,
         subject: 'You registered a team for the 2017 DEF CON CTF Quals'
  end

  def new_member_email(new_member)
    @newbie = new_member
    @team = @newbie.team
    @user = @team.user

    mail to: @newbie.email,
         bcc: @user.email,
         subject: 'You joined a team for the 2017 DEF CON CTF Quals'
  end
end
