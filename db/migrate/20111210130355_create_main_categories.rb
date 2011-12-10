class CreateMainCategories < ActiveRecord::Migration
  def change
    create_table :main_categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
