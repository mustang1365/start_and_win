class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.datetime :date_of_birth
      t.text :address
      t.text :self_description
      t.integer :user_id

      t.timestamps
    end
  end
end
