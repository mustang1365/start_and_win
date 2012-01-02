class CreateDifficultyLevelSettings < ActiveRecord::Migration
  def change
    create_table :difficulty_level_settings do |t|
      t.integer :iq_level
      t.integer :difficulty_level_id

      t.timestamps
    end
  end
end
