class AddDescriptionAndModelToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :description, :text
    add_column :transactions, :model_id, :integer
    add_column :transactions, :model_type, :string
    add_index :transactions, [:model_id, :model_type], :name => "transaction_model_index"
  end
end
