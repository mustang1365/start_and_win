#+-----------------+----------+------+-----+---------+----------------+
#| Field           | Type     | Null | Key | Default | Extra          |
#+-----------------+----------+------+-----+---------+----------------+
#| id              | int(11)  | NO   | PRI | NULL    | auto_increment |
#| begin_rating    | float    | YES  |     | 0       |                |
#| end_rating      | float    | YES  |     | 0       |                |
#| rate_of_payment | float    | YES  |     | 0       |                |
#+-----------------+----------+------+-----+---------+----------------+
class RatingRate < ActiveRecord::Base
  #TODO validation
end
