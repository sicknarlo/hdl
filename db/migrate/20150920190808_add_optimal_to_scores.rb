class AddOptimalToScores < ActiveRecord::Migration
  def change
    add_column :scores, :optimal, :float
    change_column :scores, :score, :float
  end
end
