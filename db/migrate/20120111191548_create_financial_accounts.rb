class CreateFinancialAccounts < ActiveRecord::Migration
  def change
    create_table :financial_accounts do |t|
      t.integer :user_id
      t.column :points_amount, :decimal, :scale => 0, :precision => 8
      t.column :reserved_points, :decimal, :scale => 0, :precision => 8
      t.timestamps
    end

    add_index :financial_accounts, [:user_id], :name => "f_user_index"
  end
end
