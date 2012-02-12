#encoding: utf-8
#+------------+--------------+------+-----+----------+----------------+
#| Field      | Type         | Null | Key | Default  | Extra          |
#+------------+--------------+------+-----+----------+----------------+
#| id         | int(11)      | NO   | PRI | NULL     | auto_increment |
#| text       | varchar(255) | YES  |     | NULL     |                |
#| created_at | datetime     | YES  |     | NULL     |                |
#| updated_at | datetime     | YES  |     | NULL     |                |
#| status     | varchar(255) | YES  |     | Активный |                |
#+------------+--------------+------+-----+----------+----------------+
class Question < ActiveRecord::Base
  include Modules::CategoryModule
  include Modules::PlayConditionModule

  STATUSES_HASH = {:open => 'Активный', :close => 'Завершен'}
  VARIANT_NUMBER = 4

  has_many :variants, :limit => VARIANT_NUMBER, :dependent => :destroy
  accepts_nested_attributes_for :variants, :allow_destroy => true, :reject_if => proc { |attributes| attributes['text'].blank? }
  has_many :competition_to_questions, :dependent => :destroy
  has_many :competitions, :through => :competition_to_questions
  has_one :user_to_their_question, :dependent => :destroy
  has_one :user, :through => :user_to_their_question

  validates :text, :presence => true
  validate :only_one_right_variant
  validate :number_of_variants
  validates_inclusion_of :status, :in => STATUSES_HASH.values

  #select question which displayed to other users
  scope :active, where(:status => STATUSES_HASH[:open])
  #select question which finished or closed
  scope :inactive, where(:status => STATUSES_HASH[:close])

  #creates new questions from hash. Create new one only if questing doesn't exist.
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

  private
  #count right variants add error if this number not equal to one
  def only_one_right_variant
    self.errors.add(:base, "Только один правильный вариант возможен.") if  variants.select { |v| v.answer? }.size> 1
    self.errors.add(:base, "Должен быть как миниум один правильный ответ.") if  variants.select { |v| v.answer? }.size == 0
  end

  #count variants and compare with VARIANT_NUMBER. Add error if needed
  def number_of_variants
    self.errors.add(:base, "Количество вариантов должно быть #{VARIANT_NUMBER}") if  variants.size != VARIANT_NUMBER
  end

end
