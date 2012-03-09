#encoding: utf-8
#PaymentSystem.process_payment(sender, recipient, amount, description = '', transaction_model = nil) - transfer points from sender to recipient
#PaymentSystem.process_payment_from_admin - process payment from admin fin account to user
#PaymentSystem.process_payment_from_site - process payment from site fin account to user
#PaymentSystem.process_payment_from_temp_fund - process payment from temp fund fin account to user
#PaymentSystem.process_payment_to_admin - process payment to admin fin account from user
#PaymentSystem.process_payment_to_site - process payment to site fin account from user
#PaymentSystem.process_payment_to_temp_fund - process payment to temp fund fin account from user
#PaymentSystem.pay_for_competition(current_user, competition, rating, win) - transfer founds after user finished competition(transfer participation point and win points)

#Please use block_with_rescue in your methods it execute block with begin and rescue in one transaction and return hash with :result, and :errors keys
class PaymentSystem
  extend Modules::PaymentSystem::PaymentSystemDynamicMethods

  #transfer points from sender to recipient
  #by default transfer site points. Sender/Recipient can be User, user id, or financial account
  def self.process_payment(sender, recipient, amount, description = '', transaction_model = nil)
    sender_fin_account, recipient_fin_account, result_hash = find_accounts(sender, recipient)
    return result_hash unless result_hash[:result]
    begin
      ActiveRecord::Base.transaction do
        result_hash[:errors] += sender_fin_account.decrease_balance(amount)[:errors]
        result_hash[:errors] += recipient_fin_account.increase_balance(amount)[:errors]
        Transaction.create(:sender_id => sender_fin_account.user_id, :recipient_id => recipient_fin_account.user_id,
                           :amount => amount, :description => description, :model => transaction_model)
      end
    rescue Exception => e
      Rails.logger.error('*'*100)
      Rails.logger.error(e.message)
      Rails.logger.error('*'*100)
      result_hash[:result] = false
      result_hash[:errors] << 'Произошла непредвиденная ошибка. Попробуйте позже'
    end
    result_hash[:result] = result_hash[:errors].empty?
    result_hash
  end


  #transfer founds after user finished competition(transfer participation point and win points)
  #e.g.
  #PaymentSystem.pay_for_competition(current_user, @question, rating, true)
  def pay_for_competition(current_user, competition, rating, win)
    charge_from_player_maker, charge_to_player_back, iq_for_creator, pay_for_win, iq_for_win = calculate_variables(rating, competition, win)
    block_with_rescue do |result|
      result[:errors] += PaymentSystem.process_payment_from_temp_fund(competition.user, charge_from_player_maker)
      result[:errors] += PaymentSystem.process_payment_from_temp_fund(current_user, charge_to_player_back)
      competition.user.increase_iq(iq_for_win)
      if win(current_user, amount)
        result[:errors] += PaymentSystem.process_payment(competition.financial_account,current_user, pay_for_win, "Оплата выйгрыша", competition)
        current_user.increase_iq(iq_for_win)
      end
    end

    result
  end

  private
  #return fin accounts for sender and recipient. Also return error hash
  def self.find_accounts(sender, recipient)
    sender_fin_acc = sender.instance_of?(FinancialAccount) ? sender : FinancialAccount.find_account(sender)
    recipient_fin_acc = recipient.instance_of?(FinancialAccount) ? recipient : FinancialAccount.find_account(recipient)
    result_hash = if sender_fin_acc.nil? || recipient_fin_acc.nil?
                    {:result => false, :errors => ['Транзакция невозможна по техническим причинам попробуйте позже']}
                  else
                    {:result => true, :errors => []}
                  end
    p [sender_fin_acc, recipient_fin_acc, result_hash]
    [sender_fin_acc, recipient_fin_acc, result_hash]
  end

  #execute block with begin and rescue in one transaction and return hash with :result, and :errors keys
  #TODO send email about error
  def block_with_rescue(result_hash = {:result => false, :errors => []})
    begin
      ActiveRecord::Base.transaction do
        yield(result_hash)
        raise Exception if result_hash[:errors].any?
      end
    rescue Exception => e
      Rails.logger.error('*'*100)
      Rails.logger.error(e.message)
      Rails.logger.error('*'*100)
      result_hash[:result] = false
      result_hash[:errors] << 'Произошла непредвиденная ошибка. Попробуйте позже'
    end

    result_hash
  end

  #suppot method. Find and set variables
  def calculate_variables(rating, competition, win)
    coef = RatingRate.coef_for_rating(rating.total_score)
    charge_from_player_maker = competition.play_condition.participation_points * coef
    charge_to_player_back = competition.play_condition.participation_points * (1 - coef)
    iq_for_creator = ExperienceSetting.for_competition(competition, 'creator', coef)
    if win
      pay_for_win = competition.play_condition.win_points * coef
      iq_for_win = ExperienceSetting.for_competition(competition, 'participant', coef)
    end

    [charge_from_player_maker, charge_to_player_back, iq_for_creator, win ? pay_for_win : nil, win ? iq_for_win : nil]
  end
end