class AddAministratorFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :administrator, :boolean
  end
end
