class Competition < ActiveRecord::Base
  include CategoryModule

  belongs_to :user
  belongs_to :image, :dependent => :destroy

  validates :title, :presence => true
end
