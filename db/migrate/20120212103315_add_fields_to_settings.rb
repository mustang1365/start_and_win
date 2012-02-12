class AddFieldsToSettings < ActiveRecord::Migration
  def change
    add_column :difficulty_level_settings, :competition_max_win_points, :decimal, :scale => 2, :precision => 8, :default => 0
    add_column :difficulty_level_settings, :question_max_win_points, :decimal, :scale => 2, :precision => 8, :default => 0
  end
end
