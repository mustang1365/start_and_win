module CategoryModule
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
          sub_categories_attributes.keys.each do |sub_category_id|
            model_to_main_category.model_to_main_category_to_sub_categories.build(:sub_category_id => sub_category_id )
          end
        end
      end

    end
  end
end