#encoding: utf-8
#+--------------------+--------------+------+-----+---------+----------------+
#| Field              | Type         | Null | Key | Default | Extra          |
#+--------------------+--------------+------+-----+---------+----------------+
#| id                 | int(11)      | NO   | PRI | NULL    | auto_increment |
#| competition_name   | varchar(255) | YES  |     | NULL    |                |
#| iq_for_participant | float        | YES  |     | 0       |                |
#| iq_for_creator     | float        | YES  |     | 0       |                |
#+--------------------+--------------+------+-----+---------+----------------+

#These settings define how much experience gets the party and the creator of the competition
class ExperienceSetting < ActiveRecord::Base
  SETTING_HASH = {:question => 'Блиц вопрос', :competition => 'Соревнование'}
end
