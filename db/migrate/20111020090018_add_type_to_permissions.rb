class AddTypeToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :permission_type, :string
  end
end
