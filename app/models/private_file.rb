class PrivateFile < ActiveRecord::Base
  mount_uploader :file_content, PrivateFileUploader

  alias :file? :file_content?

  def file_url
    if File.exists?("#{Rails.root}/tmp/"+ self.file_content_url)
      self.file_content_url
    else
      "default_url"
    end
  end
end
