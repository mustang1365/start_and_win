class CreateControllerAreas < ActiveRecord::Migration
  def change
    create_table :controller_areas do |t|
      t.string :controller_name
      t.string :action_name
      t.string :check_method
      t.integer :permission_id

      t.timestamps
    end
  end
end
