#+--------------+--------------+------+-----+---------+----------------+
#| Field        | Type         | Null | Key | Default | Extra          |
#+--------------+--------------+------+-----+---------+----------------+
#| id           | int(11)      | NO   | PRI | NULL    | auto_increment |
#| sender_id    | int(11)      | YES  | MUL | NULL    |                |
#| recipient_id | int(11)      | YES  | MUL | NULL    |                |
#| amount       | decimal(8,2) | YES  |     | 0.00    |                |
#| point_type   | varchar(255) | YES  |     | NULL    |                |
#| created_at   | datetime     | YES  |     | NULL    |                |
#| updated_at   | datetime     | YES  |     | NULL    |                |
#+--------------+--------------+------+-----+---------+----------------+

class Transaction < ActiveRecord::Base
  belongs_to :sender, :class_name => User, :foreign_key => :sender_id
  belongs_to :recipient, :class_name => User, :foreign_key => :recipient_id
  validates :sender_id, :recipient_id, :amount, :presence => true
end
