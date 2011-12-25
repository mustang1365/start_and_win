class ModelToMainCategory < ActiveRecord::Base
  belongs_to :main_category
  belongs_to :model, :polymorphic => true
  has_many :model_to_main_category_to_sub_categories
  accepts_nested_attributes_for :model_to_main_category_to_sub_categories
  has_many :sub_categories, :through => :model_to_main_category_to_sub_categories
end
