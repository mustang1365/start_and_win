#+--------------------+----------+------+-----+---------+----------------+
#| Field              | Type     | Null | Key | Default | Extra          |
#+--------------------+----------+------+-----+---------+----------------+
#| id                 | int(11)  | NO   | PRI | NULL    | auto_increment |
#| photo_id           | int(11)  | YES  | MUL | NULL    |                |
#| user_id            | int(11)  | YES  | MUL | NULL    |                |
#| short_description  | text     | YES  |     | NULL    |                |
#| education_level_id | int(11)  | YES  | MUL | NULL    |                |
#| created_at         | datetime | YES  |     | NULL    |                |
#| updated_at         | datetime | YES  |     | NULL    |                |
#+--------------------+----------+------+-----+---------+----------------+
class Profile < ActiveRecord::Base
  DEFAULT_URL_FOR_PHOTO =  "/assets/default_avatar.gif"
  belongs_to :education_level
  belongs_to :user
  belongs_to :photo, :class_name => 'Image', :foreign_key => :photo_id, :dependent => :destroy

  has_many :model_to_main_categories, :as => :model
  accepts_nested_attributes_for :model_to_main_categories

  def attributes=(attrs)
    #unless attrs.blank?
    #  sub_categories_attributes = attrs.delete(:sub_categories_attributes)
    #  super(attrs)
    #  model_to_main_categories.map{|mc| mc.model_to_main_category_to_sub_categories.destroy_all}
    #  sub_categories_attributes.keys.each do |sub_category_id|
    #    model_to_main_category =
    #    model_to_main_category.model_to_main_category_to_sub_categories.build(:sub_category_id => sub_category_id )
    #  end
    #end
  end


  def photo_url
    photo && photo.image_url.present? ? photo.image_url : DEFAULT_URL_FOR_PHOTO
  end
end
