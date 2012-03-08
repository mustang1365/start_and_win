class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_one :profile, :dependent => :destroy
  has_one :financial_account, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :authentications, :dependent => :destroy

  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^[a-zA-Z](([.]?([a-zA-Z0-9_-]+))*)?@([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,4}$/}
  validates :login, :presence => true
  validates :password, :presence => {:on => :create}
  validates :password, :confirmation => {:message => "should match confirmation"}, :length => {:minimum => 6, :message => "password must be at least 6 characters long"}, :if => :password

  after_create :build_necessary_models

  accepts_nested_attributes_for :authentications

  def available_difficulty_levels
    DifficultyLevel.for_iq_level(self.iq_level)
  end

  #return financial account for user
  def financial_account
      FinancialAccount.find_account(self)
  end

  private
  #creates some necessary models for user after create
  def build_necessary_models
    unless admin?
      Profile.create(:user => self)
      FinancialAccount.create(:user => self, :model => self)
    end
  end


end
