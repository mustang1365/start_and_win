class NewsPoint < ActiveRecord::Base
  validates :title, :presence => true
  mount_uploader :cover, ImageUploader
end
