class MainCategory < ActiveRecord::Base
  has_many :sub_categories, :dependent => :destroy
  accepts_nested_attributes_for :sub_categories, :allow_destroy => true, :reject_if =>  proc { |attributes| attributes['title'].blank? }
end
