class AddLosingStreak < ActiveRecord::Migration
  def change
    add_column :teams, :current_losing_streak, :integer
    add_column :teams, :worst_losing_streak, :integer
  end
end
