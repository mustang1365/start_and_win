class AddResultsToFootballMatch < ActiveRecord::Migration
  def change
    change_table :football_matches do |t|
      t.integer :goals_1
      t.integer :goals_2
      t.boolean :finished, :default=>false
    end
  end
end
