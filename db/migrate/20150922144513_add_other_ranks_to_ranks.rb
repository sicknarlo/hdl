class AddOtherRanksToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :record, :integer
    add_column :ranks, :points, :integer
    add_column :ranks, :all_play, :integer
    add_column :ranks, :efficiency, :integer
    add_column :ranks, :optimal, :integer
  end
end
