class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.float :total_score, :default => 0.0
      t.float :general_score, :default => 0.0
      t.float :difficulty_score, :default => 0.0
      t.float :time_score, :default => 0.0

      t.timestamps
    end
  end
end
