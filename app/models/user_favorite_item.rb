class UserFavoriteItem < ActiveRecord::Base
  belongs_to :profile
end

# == Schema Information
#
# Table name: user_favorite_items
#
#  id         :integer(4)      not null, primary key
#  profile_id :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

