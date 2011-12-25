class ModelToMainCategoryToSubCategory < ActiveRecord::Base
  belongs_to :model_to_main_category
  belongs_to :sub_category
end
