Recaptcha.configure do |config|
  config.public_key  = ENV['RECAPTCHA_PUBLIC_KEY'] || '6Lf_C-0SAAAAAO8kGYW_mHe-kExAv441CZaKDCdT'
  config.private_key = ENV['RECAPTCHA_PRIVATE_KEY'] || '6Lf_C-0SAAAAAHwYi5LCEYpUMz4MGm6akQ-_84bA'
end
