class CreatePlayResults < ActiveRecord::Migration
  def change
    create_table :play_results do |t|
      t.integer :user_id
      t.string :competition_type
      t.integer :competition_id
      t.string :answers
      t.boolean :won, :default => false
      t.boolean :payed, :default => false
      t.integer :rating_id
      t.timestamps
    end

    add_index :play_results, [:competition_type, :competition_id], :name => "result_competition_index"
    add_index :play_results, [:rating_id], :name => "result_rating_index"
    add_index :play_results, [:user_id], :name => "result_user_index"
  end
end
