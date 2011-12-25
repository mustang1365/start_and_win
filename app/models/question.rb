#encoding: utf-8
class Question < ActiveRecord::Base
  include CategoryModule

  VARIANT_NUMBER = 4

  has_many :variants, :limit => VARIANT_NUMBER, :dependent => :destroy
  accepts_nested_attributes_for :variants, :allow_destroy => true, :reject_if => proc { |attributes| attributes['text'].blank? }

  validates :text, :presence => true
  validate :only_one_right_variant
  validate :number_of_variants

  def only_one_right_variant
    self.errors.add(:base, "Только один правильный вариант возможен.") if  variants.select{|v| v.answer?}.size> 1
    self.errors.add(:base, "Должен быть как миниум один правильный ответ.") if  variants.select{|v| v.answer?}.size == 0
  end

  def number_of_variants
    self.errors.add(:base, "Количество вариантов должно быть #{VARIANT_NUMBER}") if  variants.size != VARIANT_NUMBER
  end


end
