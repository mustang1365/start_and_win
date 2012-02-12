#encoding: utf-8
module Modules::Question::Scopes
  def self.included(base)
    base.class_eval do
      #select question which displayed to other users
      scope :active, where(:status => Question::STATUSES_HASH[:open])
      #select question which finished or closed
      scope :inactive, where(:status => Question::STATUSES_HASH[:close])

    end
  end
end
