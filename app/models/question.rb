#encoding: utf-8
class Question < ActiveRecord::Base
  has_many :variants, :limit => 4, :dependent => :destroy
  accepts_nested_attributes_for :variants, :allow_destroy => true, :reject_if => proc { |attributes| attributes['text'].blank? }

  validates :text, :presence => true
  validate :only_one_right_variant

  def only_one_right_variant
    self.errors.add(:base, "Только один правильный вариант возможен.") if  variants.select{|v| v.answer?}.size> 1
    self.errors.add(:base, "Должен быть как миниум один правильный ответ.") if  variants.select{|v| v.answer?}.size == 0
  end
end
