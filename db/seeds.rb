# Create teams
12.times do
  team = Team.create
  team.current_streak = 0
  team.best_streak = 0
  team.current_losing_streak = 0
  team.worst_losing_streak = 0
  team.save
end