class AddGroupNameToPermission < ActiveRecord::Migration
  def change
    add_column :permissions, :group_name, :string
  end
end
