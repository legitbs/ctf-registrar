index = 1
json.standings do
  json.array! @leaderboard do |team|
    json.pos index
    json.team team['team_name']
    json.score team['score']
    index += 1
  end
end
