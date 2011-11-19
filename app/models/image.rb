class Image < ActiveRecord::Base
  mount_uploader :image_content, ImageUploader

  alias :image? :image_content?

  def photo_url(sym = nil)
    if File.exists?("public/"+ self.photo_content_url(sym))
      self.photo_content_url(sym)
    else
      "default_url"
    end
  end
end
