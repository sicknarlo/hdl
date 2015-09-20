class AddTeamToScore < ActiveRecord::Migration
  def change
    add_column :scores, :team_id, :integer
  end
end
