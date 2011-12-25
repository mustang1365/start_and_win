class CreateModelToMainCategoryToSubCategories < ActiveRecord::Migration
  def change
    create_table :model_to_main_category_to_sub_categories, :id => false do |t|
      t.integer :sub_category_id
      t.integer :model_to_main_category_id
      t.timestamps
    end

    add_index :model_to_main_category_to_sub_categories, [:sub_category_id], :name => "sub_category_index"
    add_index :model_to_main_category_to_sub_categories, [:model_to_main_category_id], :name => "model_to_main_category_index"
  end
end
