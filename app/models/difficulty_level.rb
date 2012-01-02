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
  has_one :difficulty_level_setting, :dependent => :destroy

  after_create :create_difficulty_level_setting_if_need


  def create_difficulty_level_setting_if_need
    DifficultyLevelSetting.create(:iq_level => 0, :difficulty_level => self ) if difficulty_level_setting.nil?
  end
end
