#encoding: utf-8
module Modules::Question::QuestionInstanceMethods
  def self.included(base)
    base.class_eval do
      def closed?
        status == Question::STATUSES_HASH[:close]
      end
    end
  end
end
