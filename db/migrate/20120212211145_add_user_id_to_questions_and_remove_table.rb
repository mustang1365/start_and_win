class AddUserIdToQuestionsAndRemoveTable < ActiveRecord::Migration
  def up
    add_column :questions, :user_id, :integer
    drop_table :user_to_their_questions
  end

  def down
    create_table :user_to_their_questions, :id => false do |t|
      t.integer :user_id
      t.integer :question_id
      t.timestamps
    end
    remove_column :questions, :user_id
  end
end
