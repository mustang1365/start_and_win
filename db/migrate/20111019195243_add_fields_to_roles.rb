class AddFieldsToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :description, :text
    add_column :roles, :role_type, :string
  end
end
