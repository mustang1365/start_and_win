class CreateNewsPoints < ActiveRecord::Migration
  def change
    create_table :news_points do |t|
      t.string :title
      t.text :description
      t.datetime :end_date

      t.timestamps
    end
  end
end
