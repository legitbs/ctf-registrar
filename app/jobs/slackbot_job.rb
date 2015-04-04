class SlackbotJob < ActiveJob::Base
  include Rails.application.routes.url_helpers
  queue_as :default

  def default_url_options
    Rails.configuration.action_mailer.default_url_options
  end

  def perform(message)
    begin
      payload = send(message[:kind], message)
    rescue => e
      Rails.logger.error "Slackbot payload error: #{e}"
    end

    begin
      HTTP.post SLACK_URL, json: payload
    rescue => e
      Rails.logger.error "Slackbot post error: #{e}"
    end
  end

  def user_create(message)
    user = message[:user]
    user_url = jarmandy_user_url user
    payload = {
      text: 'User signed up',
      color: 'good',
      fields: [
        { title: 'User',
          value: "<#{user_url}|#{user.username}>",
          short: true
        }
      ],
      fallback: <<-MESG }
User <#{ user_url user }|#{user.username}> signed up.
MESG
  end

  def team_create(message)
    team = message[:team]
    team_url = jarmandy_team_url team
    captain = team.user
    captain_url = jarmandy_user_url captain
    payload = {
      text: 'Team created',
      color: 'good',
      fields: [
        { title: 'Captain',
          value: "<#{captain_url}|#{captain.username}>",
          short: true },
        { title: 'Team',
          value: "<#{team_url}|#{team.name}>",
          short: true }
      ],
      fallback: <<-MESG }
Team <#{team_url}|#{team.name}> created by <#{captain_url}|#{captain.username}>.
MESG
  end

  def team_join(message)
    team = message[:team]
    team_url = jarmandy_team_url team

    member = message[:user]
    member_url = jarmandy_user_url member

    captain = team.user
    captain_url = jarmandy_user_url captain

    payload = {
      text: 'User joined team',
      color: 'good',
      fields: [
        {  title: 'Member',
           value: "<#{member_url}|#{member.username}>",
           short: true },
        {  title: 'Team',
           value: "<#{team_url}|#{team.name}>",
           short: true },
        {  title: 'Captain',
           value: "<#{captain_url}|#{captain.username}>",
           short: true }
      ],
      fallback: <<-MESG }
User <#{ member_url}|#{ member.username}> joined team <#{ team_url }|#{team.name}>.
MESG
  end
end
