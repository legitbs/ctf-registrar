json.array!(@observations) do |observation|
  json.extract! observation, :id, :team_id, :challenge_id, :user_id
  json.url observation_url(observation, format: :json)
end
