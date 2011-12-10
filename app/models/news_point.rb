class NewsPoint < ActiveRecord::Base
  belongs_to :image, :dependent => :destroy

  validates :title, :presence => true
end
