class Role < ActiveRecord::Base
  TYPES = ['user','admin']
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions
end

# == Schema Information
#
# Table name: roles
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text
#  type        :string(255)
#

