class CreateDifficultyLevels < ActiveRecord::Migration
  def change
    create_table :difficulty_levels do |t|
      t.string :name

      t.timestamps
    end

  end
end
