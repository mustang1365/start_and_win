class CreateUserFavoriteItems < ActiveRecord::Migration
  def change
    create_table :user_favorite_items do |t|
      t.integer :profile_id
      t.string :name

      t.timestamps
    end
  end
end
