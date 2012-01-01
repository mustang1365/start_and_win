#encoding: utf-8
class Question < ActiveRecord::Base
  include CategoryModule

  VARIANT_NUMBER = 4

  has_many :variants, :limit => VARIANT_NUMBER, :dependent => :destroy
  accepts_nested_attributes_for :variants, :allow_destroy => true, :reject_if => proc { |attributes| attributes['text'].blank? }
  has_many :competition_to_questions
  has_many :competitions, :through => :competition_to_questions

  validates :text, :presence => true
  validate :only_one_right_variant
  validate :number_of_variants

  def only_one_right_variant
    self.errors.add(:base, "Только один правильный вариант возможен.") if  variants.select { |v| v.answer? }.size> 1
    self.errors.add(:base, "Должен быть как миниум один правильный ответ.") if  variants.select { |v| v.answer? }.size == 0
  end

  def number_of_variants
    self.errors.add(:base, "Количество вариантов должно быть #{VARIANT_NUMBER}") if  variants.size != VARIANT_NUMBER
  end


  def self.create_from_hash(yaml_hash)
    yaml_hash.each do |q_hash|
      if Question.find_by_text(q_hash['question']).nil?
        question = Question.new(:text => q_hash['question'])
        q_hash['variants'].each do |variant|
          question.variants.build(:text => variant['name'], :answer => variant['answer'])
        end
        if q_hash['category'].present?
          main_category = MainCategory.find_by_title(q_hash['category']) || MainCategory.create(:title => q_hash['category'])
          question.build_model_to_main_category(:main_category_id => main_category.id)
          if q_hash['sub_categories'].present?
            q_hash['sub_categories'].split(',').each do |sub_c|
              sub_cat = SubCategory.find_by_title(sub_c) || SubCategory.create(:title => sub_c, :main_category => main_category)
              question.model_to_main_category.model_to_main_category_to_sub_categories.build(:sub_category_id => sub_cat.id)
            end
          end
        end
        question.save!
      end
    end
  end

end
