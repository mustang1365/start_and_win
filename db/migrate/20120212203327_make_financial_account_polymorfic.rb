class MakeFinancialAccountPolymorfic < ActiveRecord::Migration
  def change
    add_column :financial_accounts, :model_id, :integer
    add_column :financial_accounts, :model_type, :string
    add_index :financial_accounts, [:model_id, :model_type], :name => "financial_account_model_index"
  end
end
