class AddStatusToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :status, :string, :default => Question::STATUSES_HASH[:open]
  end
end
