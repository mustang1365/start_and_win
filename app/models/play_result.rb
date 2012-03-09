#+------------------+--------------+------+-----+---------+----------------+
#| Field            | Type         | Null | Key | Default | Extra          |
#+------------------+--------------+------+-----+---------+----------------+
#| id               | int(11)      | NO   | PRI | NULL    | auto_increment |
#| user_id          | int(11)      | YES  | MUL | NULL    |                |
#| competition_type | varchar(255) | YES  | MUL | NULL    |                |
#| competition_id   | int(11)      | YES  |     | NULL    |                |
#| answers          | varchar(255) | YES  |     | NULL    |                |
#| won              | tinyint(1)   | YES  |     | 0       |                |
#| payed            | tinyint(1)   | YES  |     | 0       |                |
#| rating_id        | int(11)      | YES  | MUL | NULL    |                |
#+------------------+--------------+------+-----+---------+----------------+

class PlayResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :competition, :polymorphic => true
  belongs_to :rating

  validates :user_id, :competition_id, :competition_type, :answers, :presence => true

  scope :find_for_user, lambda { |user, competition| where(:user => user, :competition => competition).first }

  after_save :set_rating_to_competition

  #set competition rating if has rating
  def set_rating_to_competition
    competition.recalculate_rating if rating.present?
  end
end
