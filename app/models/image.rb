class Image < ActiveRecord::Base
  mount_uploader :image_content, ImageUploader

  alias :image? :image_content?

  def image_url
    if File.exists?("public/"+ self.image_content_url)
      self.image_content_url
    end
  end
end
