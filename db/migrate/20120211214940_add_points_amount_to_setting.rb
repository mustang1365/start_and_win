class AddPointsAmountToSetting < ActiveRecord::Migration
  def change
    add_column :users, :iq_level, :decimal, :scale => 2, :precision => 8, :default => 0
    add_column :difficulty_level_settings, :competition_max_points, :decimal, :scale => 2, :precision => 8, :default => 0
    add_column :difficulty_level_settings, :question_max_points, :decimal, :scale => 2, :precision => 8, :default => 0
  end
end
