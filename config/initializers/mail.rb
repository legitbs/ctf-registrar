ActionMailer::Base.smtp_settings = {
    :port =>           '587',
    :address =>        ENV['SPARKPOST_SMTP_HOST'],
    :user_name =>      ENV['SPARKPOST_SMTP_USERNAME'],
    :password =>       ENV['SPARKPOST_SMTP_PASSWORD'],
    :domain =>         'legitbs.net',
    :authentication => :plain
}
# ActionMailer::Base.delivery_method = :smtp
