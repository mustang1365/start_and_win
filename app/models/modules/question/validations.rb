#encoding: utf-8
module Modules::Question::Validations
  def self.included(base)
    base.class_eval do

      validates :text, :presence => true
      validate :only_one_right_variant
      validate :number_of_variants
      validates_inclusion_of :status, :in => Question::STATUSES_HASH.values


      private
      #count right variants add error if this number not equal to one
      def only_one_right_variant
        self.errors.add(:base, "Только один правильный вариант возможен.") if  variants.select { |v| v.answer? }.size> 1
        self.errors.add(:base, "Должен быть как миниум один правильный ответ.") if  variants.select { |v| v.answer? }.size == 0
      end

      #count variants and compare with VARIANT_NUMBER. Add error if needed
      def number_of_variants
        self.errors.add(:base, "Количество вариантов должно быть #{Question::VARIANT_NUMBER}") if  variants.size != Question::VARIANT_NUMBER
      end
    end
  end
end
