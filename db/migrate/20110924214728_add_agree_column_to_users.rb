class AddAgreeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :agree_with_terms_and_conditions, :boolean, :default =>false
  end
end
