class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
    create_table :roles_users, :id => false do |t|
      t.integer :user_id
      t.integer :role_id
      t.timestamps
    end
    add_index :roles_users, :user_id
    add_index :roles_users, :role_id
  end
end
