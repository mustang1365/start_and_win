#encoding: utf-8
#+-----------------+--------------+------+-----+---------+----------------+
#| Field           | Type         | Null | Key | Default | Extra          |
#+-----------------+--------------+------+-----+---------+----------------+
#| id              | int(11)      | NO   | PRI | NULL    | auto_increment |
#| user_id         | int(11)      | YES  | MUL | NULL    |                |
#| points_amount   | decimal(8,0) | YES  |     | NULL    |                |
#| reserved_points | decimal(8,0) | YES  |     | NULL    |                |
#+-----------------+--------------+------+-----+---------+----------------+
class FinancialAccount < ActiveRecord::Base
  ADMIN_FUND = {:user_id => -1, :name => 'Администрация сайта'}  #financial account for all admins
  SITE_FUND  = {:user_id => -2, :name => 'Фонд сайта'}           #financial account for site(charge from this account bonuses, special prizes etc)
  TEMP_FUND  = {:user_id => -3, :name => 'Временный фонд сайта'} #financila account for temp actions(save money when user start play or create game)
  POINTS_TYPES  = {:standard => 'points', :reserved => 'reserved_points'}
  belongs_to :user

  include Modules::FinancialAccount::FinancialAccountClassMethods
  include Modules::FinancialAccount::FinancialAccountInstanceMethods
end



