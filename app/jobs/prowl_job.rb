class ProwlJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    begin
      payload = send(message[:kind], message)
    rescue => e
      Rails.logger.error "Prowl payload error: #{e}"
    end
    payload[:application] = 'ctf-registrar'
    payload[:apikey] = PROWL_KEY
    begin
      HTTP.post "https://api.prowlapp.com/publicapi/add", form: payload
    rescue => e
      Rails.logger.error "Prowl post error: #{e}"
    end
  end

  def popped(message)
    user = message[:user]
    team = message[:team]
    challenge = message[:challenge]

    payload = {
      event: "challenge #{challenge.name} popped",
      description:
        "#{challenge.points} points for #{team.name} won by #{user.username}"
    }
  end
end
