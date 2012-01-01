class AddDifficultyLevelToCompetition < ActiveRecord::Migration
  def up
    add_column :competitions, :difficulty_level_id, :integer
    add_index :competitions, [:difficulty_level_id], :name => "difficulty_level_index"
  end

  def down
    remove_index :competitions, :difficulty_level_index
    remove_column :competitions, :difficulty_level_id
  end
end
