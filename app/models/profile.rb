class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :user_favorite_items, :dependent => :destroy
  accepts_nested_attributes_for :user_favorite_items


  before_save :set_full_name
  after_create :set_user_name


  def set_full_name
    self.full_name = self.first_name.to_s + ' ' + self.last_name.to_s
  end

  def set_user_name
    self.user_name = self.user.email.split('@').first
    self.save
  end

  def build_associations_if_empty
     user_favorite_items.build if user_favorite_items.empty?
  end
end
