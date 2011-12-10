class Variant < ActiveRecord::Base
  belongs_to :question

  validates :text, :presence => true
end
