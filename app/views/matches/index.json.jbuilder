json.array!(@matches) do |match|
  json.extract! match, :id, :team1_id, :team2_id, :team1_score, :team2_score, :season
  json.url match_url(match, format: :json)
end
