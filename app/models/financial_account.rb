#encoding: utf-8
#+-----------------+--------------+------+-----+---------+----------------+
#| Field           | Type         | Null | Key | Default | Extra          |
#+-----------------+--------------+------+-----+---------+----------------+
#| id              | int(11)      | NO   | PRI | NULL    | auto_increment |
#| user_id         | int(11)      | YES  | MUL | NULL    |                |
#| points_amount   | decimal(8,0) | YES  |     | NULL    |                |
#| reserved_points | decimal(8,0) | YES  |     | NULL    |                |
#| model_id        | int(11)      | YES  | MUL | NULL    |                |
#| model_type      | varchar(255) | YES  |     | NULL    |                |
#+-----------------+--------------+------+-----+---------+----------------+
class FinancialAccount < ActiveRecord::Base
  ADMIN_FUND = {:user_id => -1, :name => 'Администрация сайта', :method_name => 'admin'} #financial account for all admins
  SITE_FUND = {:user_id => -2, :name => 'Фонд сайта', :method_name => 'site'} #financial account for site(charge from this account bonuses, special prizes etc)
  TEMP_FUND = {:user_id => -3, :name => 'Временный фонд сайта', :method_name => 'temp_fund'} #financila account for temp actions(save money when user start play or create game)
  FUNDS = [ADMIN_FUND, SITE_FUND, TEMP_FUND]
  POINTS_TYPES = {:standard => 'points', :reserved => 'reserved_points'}
  belongs_to :user
  belongs_to :model, :polymorphic => true #belongs to such models as questions, competitions etc
  #return all fin account that belong to users or is Special Funds
  scope :for_users, where(:model_id => nil, :model_type => nil)
  include Modules::FinancialAccount::FinancialAccountClassMethods
  include Modules::FinancialAccount::FinancialAccountInstanceMethods
end



