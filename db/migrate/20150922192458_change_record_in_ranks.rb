class ChangeRecordInRanks < ActiveRecord::Migration
  def change
    remove_column :ranks, :record
    add_column :ranks, :season_record, :integer
  end
end
