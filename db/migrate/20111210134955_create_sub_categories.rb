class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :title
      t.integer :main_category_id

      t.timestamps
    end
  end
end
