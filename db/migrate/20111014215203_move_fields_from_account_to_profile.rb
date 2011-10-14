class MoveFieldsFromAccountToProfile < ActiveRecord::Migration
  def up
    remove_column  :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :full_name
    remove_column :users, :user_name
    add_column  :profiles, :full_name, :string
    add_column  :profiles, :last_name, :string
    add_column  :profiles, :first_name, :string
    add_column  :profiles, :user_name, :string

  end

  def down
    remove_column  :profiles, :first_name
    remove_column :profiles, :last_name
    remove_column :profiles, :full_name
    add_column  :users, :full_name, :string
    add_column  :users, :last_name, :string
    add_column  :users, :first_name, :string
    add_column :users, :user_name, :string
  end
end
