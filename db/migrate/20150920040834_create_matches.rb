class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.integer :team1_score
      t.integer :team2_score
      t.integer :season

      t.timestamps null: false
    end
  end
end
