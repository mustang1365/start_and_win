class AddCompetitionPointsToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :competition_points, :decimal, :default =>0, :precision => 8, :scale => 2
  end
end
