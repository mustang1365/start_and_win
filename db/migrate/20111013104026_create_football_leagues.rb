class CreateFootballLeagues < ActiveRecord::Migration
  def change
    create_table :football_leagues do |t|
      t.string  :league_name
      t.integer :country_id
      t.integer :type_league_id
      t.text :rounds
      t.timestamps
    end
  end
end
