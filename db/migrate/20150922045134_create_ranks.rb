class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :team_id
      t.integer :rank
      t.integer :week
      t.integer :season

      t.timestamps null: false
    end
  end
end
