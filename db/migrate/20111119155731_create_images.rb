class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :image_content
      t.timestamps
    end
    add_column :news_points, :image_id, :integer
  end
end
