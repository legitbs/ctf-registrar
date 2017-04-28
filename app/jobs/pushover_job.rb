class PushoverJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    begin
      payload = send(message[:kind], message)
    rescue => e
      return Rails.logger.error "Pushover payload error: #{e}"
    end

    Pushover.send(payload)
  end

  def popped(message)
    user = message[:user]
    team = message[:team]
    challenge = message[:challenge]

    payload = {
      title: "#{challenge.name} popped by #{team.name}",
      message: "#{team.name} user #{user.username} solved it"
    }
  end

  def picked(message)
    user = message[:user]
    team = message[:team]
    challenge = message[:challenge]

    payload = {
      title: "#{challenge.name} unlocked by #{team.name}",
      message: "#{team.name} user #{user.username} unlocked it"
    }
  end
end
