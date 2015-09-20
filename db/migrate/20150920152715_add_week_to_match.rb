class AddWeekToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :week, :integer
    add_column :matches, :post_season, :boolean
  end
end
