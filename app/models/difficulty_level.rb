#+------------+--------------+------+-----+---------+----------------+
#| Field      | Type         | Null | Key | Default | Extra          |
#+------------+--------------+------+-----+---------+----------------+
#| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
#| name       | varchar(255) | YES  |     | NULL    |                |
#| created_at | datetime     | YES  |     | NULL    |                |
#| updated_at | datetime     | YES  |     | NULL    |                |
#+------------+--------------+------+-----+---------+----------------+

class DifficultyLevel < ActiveRecord::Base
  has_many :competitions

end
