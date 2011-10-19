class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.timestamps
    end
    create_table :permissions_roles, :id => false do |t|
      t.integer :role_id
      t.integer :permission_id
      t.timestamps
    end
  end
end
