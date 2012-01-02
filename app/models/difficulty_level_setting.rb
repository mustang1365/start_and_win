#+---------------------+----------+------+-----+---------+----------------+
#| Field               | Type     | Null | Key | Default | Extra          |
#+---------------------+----------+------+-----+---------+----------------+
#| id                  | int(11)  | NO   | PRI | NULL    | auto_increment |
#| iq_level            | int(11)  | YES  |     | NULL    |                |
#| difficulty_level_id | int(11)  | YES  |     | NULL    |                |
#| created_at          | datetime | YES  |     | NULL    |                |
#| updated_at          | datetime | YES  |     | NULL    |                |
#+---------------------+----------+------+-----+---------+----------------+

class DifficultyLevelSetting < ActiveRecord::Base
  belongs_to :difficulty_level
end
