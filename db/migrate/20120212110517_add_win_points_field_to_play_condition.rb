class AddWinPointsFieldToPlayCondition < ActiveRecord::Migration
  def change
    add_column :play_conditions, :win_points, :decimal, :scale => 2, :precision => 8, :default => 0
  end
end
