#encoding: utf-8
#Short methods description
#self.create_from_hash - creates new questions from hash(used for yml files)
module Modules::Question::QuestionClassMethods
  def self.included(base)
    base.class_eval do

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
    end
  end
end
