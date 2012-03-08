#encoding: utf-8
module Modules::Question::Scopes
  def self.included(base)
    base.class_eval do
      #select question which displayed to other users
      scope :active, where(:status => Question::STATUSES_HASH[:open])
      #select question which finished or closed
      scope :inactive, where(:status => Question::STATUSES_HASH[:close])
      #select questions with difficulty_level available for user
      scope :available_for_user, lambda{|user| joins(:play_condition).
                  where('play_conditions.difficulty_level_id in (?)', user.available_difficulty_levels.map(&:id))}

    end
  end
end
