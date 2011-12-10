class Competition < ActiveRecord::Base
  belongs_to :user
  belongs_to :image, :dependent => :destroy


  validates :title, :presence => true
end
