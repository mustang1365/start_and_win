class Question < ActiveRecord::Base
  has_many :variants, :limit => 4, :dependent => :destroy
  accepts_nested_attributes_for :variants, :limit => 4, :allow_destroy => true

  validates :text, :presence => true
end
