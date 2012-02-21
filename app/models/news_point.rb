class NewsPoint < ActiveRecord::Base
  belongs_to :image, :dependent => :destroy

  validates :title, :presence => true

  def news_point_image_url
    self.try(:image).try(:image_url).present? ? self.image.image_url : '/assets/pic1.png'
  end
end
