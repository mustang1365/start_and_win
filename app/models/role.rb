class Role < ActiveRecord::Base
  TYPES = ['admin', 'user']
  validates :name, :role_type, :presence => true
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  scope :admin, where(:role_type => 'admin')
end
