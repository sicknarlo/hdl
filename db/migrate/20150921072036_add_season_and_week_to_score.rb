class AddSeasonAndWeekToScore < ActiveRecord::Migration
  def change
    add_column :scores, :week, :integer
    add_column :scores, :season, :integer
  end
end
