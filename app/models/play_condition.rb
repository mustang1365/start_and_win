#+----------------------+--------------+------+-----+---------+----------------+
#| Field                | Type         | Null | Key | Default | Extra          |
#+----------------------+--------------+------+-----+---------+----------------+
#| id                   | int(11)      | NO   | PRI | NULL    | auto_increment |
#| model_id             | int(11)      | YES  | MUL | NULL    |                |
#| model_type           | varchar(255) | YES  |     | NULL    |                |
#| participation_points | decimal(8,2) | YES  |     | 0.00    |                |
#| points_to_play       | decimal(8,2) | YES  |     | 0.00    |                |
#| difficulty_level_id  | int(11)      | YES  | MUL | NULL    |                |
#| win_points           | decimal(8,2) | YES  |     | 0.00    |                |
#+----------------------+--------------+------+-----+---------+----------------+
class PlayCondition < ActiveRecord::Base
  belongs_to :model, :polymorphic => true
  belongs_to :difficulty_level
end
