class Score < ActiveRecord::Base
  belongs_to :team

  def opponent
    Team.find(self.opponent_id)
  end

  def opponent_score
    self.opponent.scores.where(week: self.week, season: self.season).first.score
  end
end
