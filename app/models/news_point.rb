class NewsPoint < ActiveRecord::Base
  has_one :image, :dependent => :destroy
end
