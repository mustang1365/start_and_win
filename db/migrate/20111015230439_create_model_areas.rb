class CreateModelAreas < ActiveRecord::Migration
  def change
    create_table :model_areas do |t|
      t.string :model_name
      t.string :check_method
      t.integer :permission_id
      t.timestamps
    end
  end
end
