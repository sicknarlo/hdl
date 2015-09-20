class RemoveColumsnFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :team1_id
    remove_column :matches, :team2_id
  end
end
