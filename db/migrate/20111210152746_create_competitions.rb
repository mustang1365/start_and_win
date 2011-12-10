class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :title
      t.text :description
      t.integer :image_id
      t.boolean :system, :default => false
      t.integer :user_id
      t.decimal :win_points, :default =>0, :precision => 8, :scale => 2
      t.decimal :participation_points, :default =>0, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end
