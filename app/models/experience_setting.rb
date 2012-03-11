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

  validates :iq_for_participant, :iq_for_creator, :presence => true
  validates_numericality_of :iq_for_participant, :iq_for_creator

  #find setting for competition and return iq level for user type.
  #user type can be 'creator' or 'participant'
  def self.for_competition(competition, user_type, coef)
    setting = ExperienceSetting.find_by_competition_name(SETTING_HASH[competition.class.to_s.underscore.to_sym])
    if setting && user_type == 'creator'
      2 * setting.iq_for_creator * coef - setting.iq_for_creator
    elsif setting && user_type == 'participant'
      setting.iq_for_participant * coef
    else
      0
    end
  end
end
