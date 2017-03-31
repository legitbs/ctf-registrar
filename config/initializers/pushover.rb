Pushover.configure do |config|
  config.user = ENV['PUSHOVER_USER']
  config.token = ENV['PUSHOVER_TOKEN']
end
