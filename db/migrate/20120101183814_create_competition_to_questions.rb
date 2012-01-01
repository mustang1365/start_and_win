class CreateCompetitionToQuestions < ActiveRecord::Migration
  def change
    create_table :competition_to_questions  do |t|
      t.integer :question_id
      t.integer :competition_id

      t.timestamps
    end
  end
end
