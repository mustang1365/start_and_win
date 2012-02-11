class MessageInstallMigration < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.string :subject

      t.timestamps
    end

    create_table :message_copies do |t|
      t.integer :recipient_id
      t.integer :sender_id
      t.integer :message_id
      t.boolean :deleted, :default => false
      t.datetime :read_at

      t.timestamps
    end

    add_index :message_copies, [:sender_id], :name => "copy_sender_index"
    add_index :message_copies, [:recipient_id], :name => "copy_recipient_index"
    add_index :message_copies, [:message_id], :name => "copy_message_index"
  end
end