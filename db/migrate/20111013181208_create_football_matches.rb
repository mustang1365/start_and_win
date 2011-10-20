class CreateFootballMatches < ActiveRecord::Migration
  def change
    create_table :football_matches do |t|
      t.integer  :team1_id
      t.integer  :team2_id
      t.integer  :football_league_id
      t.string   :round
      t.datetime :started_at
      t.datetime :finished_at
    end
  end
end
