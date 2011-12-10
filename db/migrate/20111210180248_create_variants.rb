class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.string :text
      t.integer :question_id
      t.boolean :answer, :default => false
      t.timestamps
    end
  end
end
