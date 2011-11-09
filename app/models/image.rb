class Image < ActiveRecord::Base

  belongs_to :having_file, :polymorphic => true
  has_many :model_to_types, :as => :has_model, :dependent => :destroy

  mount_uploader :file_content, ImageUploader

  alias :file_url :file_content_url
  alias :file? :file_content?

end