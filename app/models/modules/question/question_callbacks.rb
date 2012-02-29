#encoding: utf-8
module Modules::Question::QuestionCallbacks
  def self.included(base)
    base.class_eval do
      after_create :charge_points_to_question

      private
      def charge_points_to_question
        if self.user_id.present? && self.play_condition.present?
          FinancialAccount.create(:user_id => self.user_id, :model => self, :points_amount => 0) if self.financial_account.nil?
          self.reload #if financial account created it should be load
          PaymentSystem.process_payment(user.financial_account, self.financial_account, self.play_condition.points_to_play,
                                              "Перевод на временный фонд для вопроса '#{self.text}'", self)
        end
      end
    end
  end
end