#encoding: utf-8
#+------------+--------------+------+-----+----------+----------------+
#| Field      | Type         | Null | Key | Default  | Extra          |
#+------------+--------------+------+-----+----------+----------------+
#| id         | int(11)      | NO   | PRI | NULL     | auto_increment |
#| text       | varchar(255) | YES  |     | NULL     |                |
#| created_at | datetime     | YES  |     | NULL     |                |
#| updated_at | datetime     | YES  |     | NULL     |                |
#| status     | varchar(255) | YES  |     | Активный |                |
#+------------+--------------+------+-----+----------+----------------+
class Question < ActiveRecord::Base
  STATUSES_HASH = {:open => 'Активный', :close => 'Завершен'}
  VARIANT_NUMBER = 4
  include Modules::CategoryModule
  include Modules::PlayConditionModule
  include Modules::Question::Validations
  include Modules::Question::Associations
  include Modules::Question::Scopes
  include Modules::Question::QuestionClassMethods
  include Modules::Question::QuestionInstanceMethods
end
