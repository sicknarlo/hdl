class Ranker

  def rank_week(week, season)
    Team.all.each do |team|
      rank = Rank.new
      rank.team_id = team.id
      rank.rank = team.power_rank_weekly(week, season)
      rank.week = week
      rank.season = season
      rank.save
    end
  end

  def season_rank(week, season)
    Team.all.each do |team|
      rank = Rank.new
      rank.team_id = team.id
      rank.rank = team.power_rank_season_team(season)
      rank.week = week
      rank.season = season

      rank.season_record = team.record_season_rank(season)

      rank.points = team.points_rank_season(season)

      rank.all_play = team.all_play_by_season_rank(season)

      rank.efficiency = team.efficiency_rank_season(season)

      rank.optimal = team.optimal_rank_season(season)

      rank.save
    end
  end

  def add_ranks(week, season)
    Team.all.each do |team|
      rank = team.ranks.where(week: week, season: season).first
      rank.record = team.record_season_rank(season)
      rank.points = team.points_rank_season(season)
      rank.all_play = team.all_play_by_season_rank(season)
      ranks.efficiency = team.efficiency_rank_season(season)
      ranks.optimal = optimal_rank_season(season)
      rank.save
    end
  end
end