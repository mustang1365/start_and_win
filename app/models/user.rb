#encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :profile
  has_and_belongs_to_many :roles
  has_many :permissions, :through => :roles
  after_create :set_default_roles

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validate :check_agreement

  def check_agreement
    self.errors[:base] << 'Для регистрации необходимо принять пользовательское соглашение' unless self.agree_with_terms_and_conditions
  end

  def set_default_roles
    self.roles << Role.find_by_name('Standard User')
  end

  def current_ability
    ability_hash = {}
    self.permissions.each do |permission|
      p_name = permission.name
      permission.controller_areas.each do |c_area|
        if ability_hash[:controllers][c_area.controller_name].nil?
           ability_hash[:controllers][c_area.controller_name] = {c_area.action_name =>c_area.check_method}
        else
          ability_hash[:controllers][c_area.controller_name].merge({c_area.action_name =>c_area.check_method})
        end
      end

      permission.model_areas.each do |m_area|
        if ability_hash[:permission][p_name].nil?
           ability_hash[:permission][p_name] = {m_area.model_name => m_area}
        end
      end
    end
  end
end
