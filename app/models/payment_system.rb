#encoding: utf-8
#PaymentSystem.process_payment(sender, recipient, amount, description = '', transaction_model = nil) - transfer points from sender to recipient
#PaymentSystem.process_payment_from_admin - process payment from admin fin account to user
#PaymentSystem.process_payment_from_site - process payment from site fin account to user
#PaymentSystem.process_payment_from_temp_fund - process payment from temp fund fin account to user
#PaymentSystem.process_payment_to_admin - process payment to admin fin account from user
#PaymentSystem.process_payment_to_site - process payment to site fin account from user
#PaymentSystem.process_payment_to_temp_fund - process payment to temp fund fin account from user
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
                           :amount => amount, :description => description ,:model => transaction_model)
      end
    rescue Exception => e
      Rails.logger.error('*'*100)
      Rails.logger.error(e.message)
      Rails.logger.error('*'*100)
      result_hash[:result] = false
      #result_hash[:errors] << e.message
      result_hash[:errors] << 'Произошла непредвиденная ошибка. Попробуйте позже'
    end
    result_hash[:result] = result_hash[:errors].empty?
    result_hash
  end


  private
  #return fin accounts for sender and recipient. Also return error hash
  def self.find_accounts(sender, recipient)
    sender_fin_acc = sender.instance_of?(FinancialAccount) ? sender : FinancialAccount.find_account(sender)
    recipient_fin_acc = recipient.instance_of?(FinancialAccount) ? recipient :  FinancialAccount.find_account(recipient)
    result_hash = if sender_fin_acc.nil? || recipient_fin_acc.nil?
                    {:result => false, :errors => ['Транзакция невозможна по техническим причинам попробуйте позже']}
                  else
                    {:result => true, :errors => []}
                  end
    [sender_fin_acc, recipient_fin_acc, result_hash]
  end

end