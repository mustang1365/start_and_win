# == Schema Information
#
# Table name: permissions
#
#  id              :integer(4)      not null, primary key
#  name            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  permission_type :string(255)
#
class Permission < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :users, :through => :roles
  has_many :model_areas
  has_many :controller_areas
end


