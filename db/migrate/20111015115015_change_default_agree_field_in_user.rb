class ChangeDefaultAgreeFieldInUser < ActiveRecord::Migration
  def up
    change_column :users, :agree_with_terms_and_conditions, :boolean, :default => false
  end

  def down
    change_column :users, :agree_with_terms_and_conditions, :boolean, :default => true
  end
end
