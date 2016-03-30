class UserMailer < ActionMailer::Base
  default from: "team@legitbs.net", template_path: 'user_mailer'

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: 'Welcome to 2016 DEF CON CTF Qualifications'
  end
end
