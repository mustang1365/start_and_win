class AddCoverToNewsPoint < ActiveRecord::Migration
  def change
    add_column :news_points, :cover, :string
  end
end
