class PushbulletJob < ActiveJob::Base
  queue_as :default

  def perform(message)
    begin
      payload = send(message[:kind], message)
    rescue => e
      return Rails.logger.error "Pushbullet payload error: #{e}"
    end

    HTTP.
      headers('Access-Token' => ENV['PUSHBULLET_KEY'],
              'Content-Type' => 'application/json').
      post(
        "https://api.pushbullet.com/v2/pushes",
        json: payload.merge(channel: ENV['PUSHBULLET_CHANNEL'])
      )
  end
#     --data-binary '{"body":"Space Elevator, Mars Hyperloop, Space Model S (Model Space?)","title":"Space Travel Ideas","type":"note"}' \

  def popped(message)
    user = message[:user]
    team = message[:team]
    challenge = message[:challenge]

    payload = {
      title: "#{challenge.name} popped by #{team.name}",
      body: "#{team.name} user #{user.username} solved it",
      type: 'note'
    }
  end

  def picked(message)
    user = message[:user]
    team = message[:team]
    challenge = message[:challenge]

    payload = {
      title: "#{challenge.name} unlocked by #{team.name}",
      body: "#{team.name} user #{user.username} unlocked it",
      type: 'note'
    }
  end
end
