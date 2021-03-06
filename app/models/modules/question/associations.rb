#encoding: utf-8
module Modules::Question::Associations
  def self.included(base)
    base.class_eval do
      has_many :variants, :limit => Question::VARIANT_NUMBER, :dependent => :destroy
      accepts_nested_attributes_for :variants, :allow_destroy => true, :reject_if => proc { |attributes| attributes['text'].blank? }
      has_many :competition_to_questions, :dependent => :destroy
      has_many :competitions, :through => :competition_to_questions
      belongs_to :user
      has_one :financial_account, :as => :model, :dependent => :destroy
    end
  end
end
