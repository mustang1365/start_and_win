class SubCategory < ActiveRecord::Base
  belongs_to :main_category
end
