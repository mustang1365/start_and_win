class CreateFootballTeams < ActiveRecord::Migration
  def change
    create_table :football_teams do |t|
      t.integer :football_league_id
      t.string :team_name
      t.timestamps
    end
  end
end
