#encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :profile


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validate :check_agreement

  before_save :set_full_name
  after_create :set_user_name

  def check_agreement
    self.errors[:base] << 'Для регистрации необходимо принять пользовательское соглашение' unless self.agree_with_terms_and_conditions
  end

  def set_full_name
    self.full_name = self.first_name.to_s + ' ' + self.last_name.to_s
  end

  def set_user_name
    self.user_name = self.email.split('@').first
  end
end
