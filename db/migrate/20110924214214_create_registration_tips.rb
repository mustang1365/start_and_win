class CreateRegistrationTips < ActiveRecord::Migration
  def change
    create_table :registration_tips do |t|
      t.text :content

      t.timestamps
    end
  end
end
