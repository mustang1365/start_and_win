class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :image_content
      t.integer :model_id
      t.string :model_type

      t.timestamps
    end
  end
end
