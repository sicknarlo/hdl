class RemoveMatchId < ActiveRecord::Migration
  def change
    remove_column :scores, :match_id
  end
end
