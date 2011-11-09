class CreateImageTable < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string :file_content
      t.integer :having_file_id
      t.string :having_file_type
      t.boolean :deleted
      t.string :asset_file_type
      t.timestamps
    end
  end

  def down
    drop_table :images
  end
end
