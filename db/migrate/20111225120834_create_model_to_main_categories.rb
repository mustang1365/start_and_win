class CreateModelToMainCategories < ActiveRecord::Migration
  def change
    create_table :model_to_main_categories  do |t|
      t.integer :main_category_id
      t.integer :model_id
      t.string :model_type
      t.timestamps
    end

    add_index :model_to_main_categories, [:main_category_id], :name => "main_category_index"
    add_index :model_to_main_categories, [:model_id, :model_type], :name => "model_cat_index"
  end
end
