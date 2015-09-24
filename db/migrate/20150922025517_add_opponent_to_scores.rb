class AddOpponentToScores < ActiveRecord::Migration
  def change
    add_column :scores, :opponent_id, :integer
  end
end
