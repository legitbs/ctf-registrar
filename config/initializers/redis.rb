REDIS = Redis.new(url: ENV["REDIS_URL"])
REDIS_CHANNEL = "ctf-registrar-#{Rails.env}"
