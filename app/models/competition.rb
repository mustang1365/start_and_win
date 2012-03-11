#encoding: utf-8
#+----------------------+--------------+------+-----+---------+----------------+
#| Field                | Type         | Null | Key | Default | Extra          |
#+----------------------+--------------+------+-----+---------+----------------+
#| id                   | int(11)      | NO   | PRI | NULL    | auto_increment |
#| title                | varchar(255) | YES  |     | NULL    |                |
#| description          | text         | YES  |     | NULL    |                |
#| image_id             | int(11)      | YES  |     | NULL    |                |
#| system               | tinyint(1)   | YES  |     | 0       |                |
#| user_id              | int(11)      | YES  |     | NULL    |                |
#| win_points           | decimal(8,2) | YES  |     | 0.00    |                |
#| participation_points | decimal(8,2) | YES  |     | 0.00    |                |
#| rating               | float        | YES  |     | 0       |                |
#| created_at           | datetime     | YES  |     | NULL    |                |
#| updated_at           | datetime     | YES  |     | NULL    |                |
#+----------------------+--------------+------+-----+---------+----------------+

class Competition < ActiveRecord::Base
  QUESTION_AMOUNT = 10

  include Modules::CategoryModule


  has_many :competition_to_questions, :dependent => :destroy
  has_many :questions, :through => :competition_to_questions, :dependent => :destroy
  accepts_nested_attributes_for :questions

  belongs_to :user
  belongs_to :image, :dependent => :destroy
  belongs_to :difficulty_level

  validates :title,:difficulty_level, :presence => true
  validate :check_question_amount

  def check_question_amount
      errors.add(:base, "Количество вопросов должно быть #{QUESTION_AMOUNT}") if questions.count != QUESTION_AMOUNT
  end
end
