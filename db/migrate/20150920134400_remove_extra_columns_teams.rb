class RemoveExtraColumnsTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :points_for
    remove_column :teams, :points_against
    remove_column :teams, :wins
    remove_column :teams, :losses
    remove_column :teams, :ties
    remove_column :teams, :post_wins
    remove_column :teams, :post_losses
    remove_column :teams, :highest_score
    remove_column :teams, :lowest_score
    remove_column :teams, :blowouts
    remove_column :teams, :top_gm
  end
end
