class RedisJob < ActiveJob::Base
  def perform(message)
    REDIS.publish(REDIS_CHANNEL, message.to_json)
  end
end
