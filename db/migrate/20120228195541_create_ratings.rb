class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :total_score, :default => 0.0
      t.integer :general_score, :default => 5
      t.integer :difficulty_score, :default => 5
      t.integer :time_score, :default => 5

      t.timestamps
    end
  end
end
