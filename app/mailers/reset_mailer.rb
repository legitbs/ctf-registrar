class ResetMailer < ActionMailer::Base
  default from: "team@legitbs.net", template_path: 'reset_mailer'

  def reset_email(reset, token)
    @reset = reset
    @user = @reset.user

    @url = reset_url token

    mail to: @user.email, subject: 'Attempting to reset your DEF CON CTF password'
  end

  def did_reset_email(reset)
    @reset = reset
    @user = @reset.user

    mail to: @user.email, subject: 'Your DEF CON CTF password was reset'
  end
end
