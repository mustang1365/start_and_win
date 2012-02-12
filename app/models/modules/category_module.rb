#encoding: utf-8
module Modules::CategoryModule
  def self.included(base)
    base.class_eval do
      has_one :model_to_main_category, :as => :model
      accepts_nested_attributes_for :model_to_main_category
      has_one :main_category, :through => :model_to_main_category
      has_many :sub_categories, :through => :model_to_main_category

      def attributes=(attrs)
        unless attrs.blank?
          sub_categories_attributes = attrs.delete(:sub_categories_attributes)

          super(attrs)
          model_to_main_category.model_to_main_category_to_sub_categories.destroy_all
          set_category_attrs(model_to_main_category, sub_categories_attributes) if sub_categories_attributes.present?
        end
      end

      def set_category_attrs(model_to_main_category, sub_categories_attributes)
        sub_categories_attributes.keys.each do |sub_category_id|
          model_to_main_category.model_to_main_category_to_sub_categories.build(:sub_category_id => sub_category_id)
        end
      end

      def set_play_conditions

      end
    end
  end
end