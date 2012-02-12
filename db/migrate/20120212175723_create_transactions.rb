class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.decimal :amount, :default => 0, :precision => 8, :scale => 2
      t.string :point_type

      t.timestamps
    end
    add_index :transactions, [:sender_id], :name => "transactions_sender_index"
    add_index :transactions, [:recipient_id], :name => "transactions_recipient_index"
  end
end
