json.array!(@teams) do |team|
  json.extract! team, :id, :name, :owners, :points_for, :points_against, :wins, :losses, :ties, :efficiency, :current_streak, :best_streak, :post_wins, :post_losses, :highest_score, :lowest_score, :blowouts, :top_gm
  json.url team_url(team, format: :json)
end
