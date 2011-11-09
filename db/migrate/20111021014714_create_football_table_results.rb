class CreateFootballTableResults < ActiveRecord::Migration
  def change
    create_table :football_table_results do |t|
      t.integer :football_league_id
      t.integer :football_team_id
      t.integer :play_matches, :default => 0
      t.integer :goals_in, :default => 0
      t.integer :goals_out, :default => 0
      t.integer :wins, :default => 0
      t.integer :draws, :default => 0
      t.integer :loses, :default => 0
      t.integer :goal_diff, :default => 0

      t.timestamps
    end
  end
end
