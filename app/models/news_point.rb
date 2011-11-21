class NewsPoint < ActiveRecord::Base
  validates :title, :presence => true
  belongs_to :image, :dependent => :destroy
end
