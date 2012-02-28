#+------------------+----------+------+-----+---------+----------------+
#| Field            | Type     | Null | Key | Default | Extra          |
#+------------------+----------+------+-----+---------+----------------+
#| id               | int(11)  | NO   | PRI | NULL    | auto_increment |
#| total_score      | float    | YES  |     | 0       |                |
#| general_score    | float    | YES  |     | 0       |                |
#| difficulty_score | float    | YES  |     | 0       |                |
#| time_score       | float    | YES  |     | 0       |                |
#+------------------+----------+------+-----+---------+----------------+
class Rating < ActiveRecord::Base
  SCORE_ARRAY = %w(general_score difficulty_score time_score)
  after_save :update_total_score


  private
  def update_total_score
     new_total_score = SCORE_ARRAY.inject(0){|result, score| result += score.to_f}/SCORE_ARRAY.size
     update_column(:total_score, new_total_score)
  end
end
