#encoding: utf-8
module Modules::PlayConditionModule
  def self.included(base)
    base.class_eval do
      has_one :play_condition, :as => :model, :dependent => :destroy
      accepts_nested_attributes_for :play_condition

      validate :condition_validation

      #validate play_condition(difficulty level, points)
      private
      def condition_validation
        if play_condition
          difficulty_level_validation
          participation_validation
          max_win_points_validation
          user_points_validation
        end
      end

      #validate iq level of user and difficulty level of model(question, competition)
      def difficulty_level_validation
        if play_condition.difficulty_level.blank?
          self.errors.add(:base, "Пожалуйста, выберите уровень сложности.")
        elsif !DifficultyLevel.for_iq_level(self.user.try(:iq_level).to_f).include?(play_condition.difficulty_level)
          self.errors.add(:base, "У вас недостаточный уровень для создания вопросов с таким уровнем сложности")
        end
      end

      #validate participation_points, their amount depends on admin settings
      def participation_validation
        if play_condition.participation_points.blank?
          self.errors.add(:base, "Количество очков за участие должно быть больше 0")
        elsif play_condition.difficulty_level.present? && play_condition.difficulty_level.difficulty_level_setting.send("#{self.class.to_s.underscore}_max_points").to_f > play_condition.participation_points.to_f
          self.errors.add(:base, "Количество очков за участие должно быть не больше #{play_condition.difficulty_level.difficulty_level_setting.send("#{self.class.to_s.underscore}_max_points")}")
        end
      end

      #validate win points, their amount depends on admin settings
      def max_win_points_validation
        if play_condition.win_points.blank?
          self.errors.add(:base, "Количество очков за победу должно быть больше 0")
        elsif play_condition.difficulty_level.present? && play_condition.difficulty_level.difficulty_level_setting.send("#{self.class.to_s.underscore}_max_win_points").to_f < play_condition.win_points.to_f
          self.errors.add(:base, "Количество очков за победу должно быть не больше #{play_condition.difficulty_level.difficulty_level_setting.send("#{self.class.to_s.underscore}_max_win_points")}")
        elsif play_condition.win_points.to_f <=  play_condition.participation_points.to_f
          self.errors.add(:base, "Количество очков за победу должно быть больше, чем количество очков за участие.")
        end
      end

      def user_points_validation
        self.errors.add(:base, "У вас недостаточно средств для создания вопроса.") if self.user.try(:financial_account).try(:points_amount).to_f < self.play_condition.points_to_play
      end
    end
  end
end