class Role < ActiveRecord::Base
  TYPES = ['user','admin']
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions
end
