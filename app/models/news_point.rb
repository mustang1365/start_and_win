class NewsPoint < ActiveRecord::Base
  has_one :image, :as => :model, :dependent => :destroy
end
