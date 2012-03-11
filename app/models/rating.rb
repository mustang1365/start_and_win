#encoding: utf-8
#+------------------+------------+------+-----+---------+----------------+
#| Field            | Type       | Null | Key | Default | Extra          |
#+------------------+------------+------+-----+---------+----------------+
#| id               | int(11)    | NO   | PRI | NULL    | auto_increment |
#| total_score      | float      | YES  |     | 0       |                |
#| general_score    | int(11)    | YES  |     | 5       |                |
#| difficulty_score | int(11)    | YES  |     | 5       |                |
#| time_score       | int(11)    | YES  |     | 5       |                |
#| rating           | float      | YES  |     | 0       |                |
#+------------------+------------+------+-----+---------+----------------+
class Rating < ActiveRecord::Base
  SCORE_ARRAY = %w(general_score difficulty_score time_score)
  SCORE_TRANSLATE = {'general_score' => 'Общее впечатление', 'difficulty_score' =>'Соответствие заявленной сложности',
                     'time_score' => 'Соответсвие отведенному времени'}

  after_save :update_total_score


  private
  def update_total_score
     self.update_column(:total_score, calculate_average_score)
  end

  def calculate_average_score
    SCORE_ARRAY.inject(0){|result, score| result += self.send("#{score}").to_f}/SCORE_ARRAY.size
  end
end
