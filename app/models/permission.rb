class Permission < ActiveRecord::Base
  has_and_belongs_to_many :roles
  has_many :users, :through => :roles
  has_many :model_areas
  has_many :controller_areas
end
