class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :photo_id
      t.integer :user_id
      t.text :short_description
      t.integer :education_level_id
      t.timestamps
    end
    add_index :profiles, [:user_id], :name => "users_index"
    add_index :profiles, [:photo_id], :name => "photo_index"
    add_index :profiles, [:education_level_id], :name => "education_level_index"
  end
end
