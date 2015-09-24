class Team < ActiveRecord::Base
  has_many :scores, :dependent => :destroy
  has_many :ranks
  # has_many :matches, :through => :scores, :source => :match_id

  def points_for
    sum = 0
    self.scores.each do |s|
      sum += s.score
    end
    sum
  end

  def season_score(season)
    sum = 0
    ranks.where(season: season).each do |rank|
      sum += rank.rank
    end
    sum
  end

  def season_rank(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.season_score(season) <=> b.season_score(season)}
    teams.find_index(self) + 1
  end

  def points_for_season(season)
    sum = 0
    self.scores.where(season: season).each do |s|
      sum += s.score
    end
    sum
  end

  def points_for_week(week, season)
    scores.where(week: week, season: season).first
  end

  def total_optimal
    sum = 0
    self.scores.each do |s|
      sum += s.optimal
    end
    sum
  end

  def points_rank
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for <=> b.points_for}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def points_rank_week(week, season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_week(week, season) <=> b.points_for_week(week, season)}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def points_rank_season(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_season(season) <=> b.points_for_season(season)}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def efficiency_rank
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for <=> b.points_for}
    teams.sort! {|a, b| a.total_efficiency <=> b.total_efficiency}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def optimal_week_rank(week, season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_week(week, season) <=> b.points_for_week(week, season)}
    teams.sort! {|a, b| a.scores.where(week: week, season: season).first.optimal <=> b.scores.where(week: week, season: season).first.optimal}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def efficiency_rank_week(week, season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.scores.where(week: week, season: season).first <=> b.scores.where(week: week, season: season).first}
    teams.sort! {|a, b| a.week_efficiency(week, season) <=> b.week_efficiency(week, season)}
    teams.reverse!
    teams.find_index(self) + 1
  end

   def efficiency_rank_season(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_season(season) <=> b.points_for_season(season)}
    teams.sort! {|a, b| a.season_efficiency(season) <=> b.season_efficiency(season)}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def week_efficiency(week, season)
    score = self.scores.where(week: week, season: season).first
    ((score.score / score.optimal) * 100).round(2)
  end

  def season_efficiency(season)
    pf = 0
    optimal = 0
    scores.where(season: season).each do |s|
      pf += s.score
      optimal += s.optimal
    end
    ((pf / optimal) * 100).round(2)
  end

  def total_efficiency
    ((self.points_for / self.total_optimal) * 100).round(2)
  end

  def all_play_by_week_score(week, season)
    record = all_play_by_week(week, season)
    record[-1]
  end

  def all_play_by_season_score(season)
    record = all_play_by_season(season)
    record[-1]
  end

  def all_play_by_week_rank(week, season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.scores.where(week: week, season: season).first <=> b.scores.where(week: week, season: season).first}
    teams.sort! {|a, b| a.all_play_by_week_score(week, season) <=> b.all_play_by_week_score(week, season)}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def all_play_by_season_rank(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_season(season) <=> b.points_for_season(season)}
    teams.sort! {|a, b| a.all_play_by_season_score(season) <=> b.all_play_by_season_score(season)}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def power_score_week(week, season)
    sum = 0
    sum += self.record_season_rank(season)
    sum += self.points_rank_week(week, season)
    sum += self.all_play_by_week_rank(week, season)
    sum += self.efficiency_rank_week(week, season)
    sum += self.optimal_week_rank(week, season)
  end

  def power_score_season(season)
    sum = 0
    sum += self.record_season_rank(season)
    sum += self.points_rank_season(season)
    sum += self.all_play_by_season_rank(season)
    sum += self.efficiency_rank_season(season)
    sum += self.optimal_rank_season(season)
  end

  def self.power_rank_season(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_season(season) <=> b.points_for_season(season)}
    teams.sort! {|a, b| a.power_score_season(season) <=> b.power_score_season(season)}
    return teams
    # teams.find_index(self) + 1
  end

  def power_rank_season_team(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_season(season) <=> b.points_for_season(season)}
    teams.sort! {|a, b| a.power_score_season(season) <=> b.power_score_season(season)}
    # return teams
    teams.find_index(self) + 1
  end


  def optimal_points_season(season)
    sum = 0
    scores.where(season: 2015).each do |s|
      sum += s.optimal
    end
    sum
  end

  def optimal_rank_season(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.optimal_points_season(season) <=> b.optimal_points_season(season)}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def power_rank_weekly(week, season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.scores.where(week:week, season: season).first <=> b.scores.where(week:week, season: season).first}
    teams.sort! {|a, b| a.power_score_week(week, season) <=> b.power_score_week(week, season)}
    teams.find_index(self) + 1
  end

  def record_season(season)
    wins = 0
    losses = 0
    ties = 0
    scores = self.scores.where(season: season)
    scores.each do |s|
      wins += 1 if s.score > s.opponent_score
      losses += 1 if s.score < s.opponent_score
      ties += 1 if s.score == s.opponent_score
    end
    [wins, losses, ties, (wins.to_f / (wins + losses + ties)).round(3)]
  end

  def record
    wins = 0
    losses = 0
    ties = 0
    scores = self.scores
    scores.each do |s|
      wins += 1 if s.score > s.opponent_score
      losses += 1 if s.score < s.opponent_score
      ties += 1 if s.score == s.opponent_score
    end
    [wins, losses, ties, (wins.to_f / (wins + losses + ties)).round(3)]
  end

  def record_season_rank(season)
    teams = []
    Team.all.each {|t| teams << t}
    teams.sort! {|a, b| a.points_for_season(season) <=> b.points_for_season(season)}
    teams.sort! {|a, b| a.record_season(season)[-1] <=> b.record_season(season)[-1]}
    teams.reverse!
    teams.find_index(self) + 1
  end

  def all_play_by_week(week, season)
    wins = 0
    losses = 0
    ties = 0
    tscore = self.scores.where(week: week, season: season).first.score
    scores = Score.where(week: week, season: season)
    scores.each do |score|
      if score.team.id != self.id
        wins += 1 if tscore > score.score
        losses += 1 if tscore < score.score
        ties += 1 if tscore == score.score
      end
    end
    [wins, losses, ties, (wins.to_f / (wins + losses + ties)).round(3)]
  end

  def all_play_by_season(season)
    wins = 0
    losses = 0
    ties = 0
    scores.where(season: season).each do |s|
      r = all_play_by_week(s.week, season)
      wins += r[0]
      losses += r[1]
      ties += r[2]
    end
    [wins, losses, ties, (wins.to_f / (wins + losses + ties)).round(3)]
  end

end