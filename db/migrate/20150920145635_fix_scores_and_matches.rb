class FixScoresAndMatches < ActiveRecord::Migration
  def change
    add_column :scores, :match_id, :integer
  end
end
