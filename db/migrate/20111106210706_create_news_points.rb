class CreateNewsPoints < ActiveRecord::Migration
  def change
    create_table :news_points do |t|
      t.string :title
      t.text :text
      t.datetime :expire_date

      t.timestamps
    end
  end
end
