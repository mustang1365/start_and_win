class NewsPoint < ActiveRecord::Base
  belongs_to :image, :dependent => :destroy

  validates :title, :presence => true


  def news_point_image_url
    self.image.image_url.present? ? self.image.image_url : '/assets/pic1.png'
  end
end
