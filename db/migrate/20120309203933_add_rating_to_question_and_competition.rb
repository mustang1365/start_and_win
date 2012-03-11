class AddRatingToQuestionAndCompetition < ActiveRecord::Migration
  def change
    add_column :questions, :rating, :float, :default => 0
    add_column :competitions, :rating, :float, :default => 0
  end
end
