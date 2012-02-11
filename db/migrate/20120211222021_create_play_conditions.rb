class CreatePlayConditions < ActiveRecord::Migration
  def change
    create_table :play_conditions do |t|
      t.integer :model_id
      t.string :model_type
      t.decimal :participation_points, :default => 0, :precision => 8, :scale => 2
      t.decimal :points_to_play, :default => 0, :precision => 8, :scale => 2
      t.integer :difficulty_level_id

      t.timestamps
    end
    add_index :play_conditions, [:model_id, :model_type], :name => "play_model_index"
    add_index :play_conditions, [:difficulty_level_id], :name => "play_difficulty_level_index"
  end
end
