class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :owners
      t.integer :points_for
      t.integer :points_against
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.integer :efficiency
      t.integer :current_streak
      t.integer :best_streak
      t.integer :post_wins
      t.integer :post_losses
      t.integer :highest_score
      t.integer :lowest_score
      t.integer :blowouts
      t.integer :top_gm

      t.timestamps null: false
    end
  end
end
