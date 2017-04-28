class TwitterJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    begin
      payload = send(message[:kind], message)
    rescue => e
      return Rails.logger.error "TwitterJob payload error: #{e}"
    end

    TwitterClient.update payload
  end

  def popped(message)
    team = message[:team]
    challenge = message[:challenge]

    "Congratulations #{team.name.truncate(40)} on popping #{challenge.name}!"
  end

  def picked(message)
    team = message[:team]
    challenge = message[:challenge]

    "The #{challenge.name} challenge was unlocked by #{team.name.truncate(40)}. Get hacking!"
  end
end
