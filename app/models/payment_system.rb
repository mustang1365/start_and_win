#encoding: utf-8
#PaymentSystem.process_payment(sender, recipient, amount) - transfer funds from sender to recipient
class PaymentSystem

  #transfer funds from sender to recipient
  #by default transfer site points
  def self.process_payment(sender, recipient, amount)
    sender_fin_account, recipient_fin_account, result_hash = find_accounts(sender, recipient)
    return result_hash unless result_hash[:result]
    begin
      ActiveRecord::Base.transaction do
        result_hash[:errors] += sender_fin_account.decrease_balance(amount)[:errors]
        result_hash[:errors] += recipient_fin_account.increase_balance(amount)[:errors]
        Transaction.create(:sender_id => sender_fin_account.user_id, :recipient_id => recipient_fin_account.user_id, :amount => amount)
      end
    rescue Exception => e
      result_hash[:result] = false
      result_hash[:errors] << 'Произошла непредвиденная ошибка. Попробуйте позже'
    end
    result_hash[:result] = result_hash[:errors].empty?
    result_hash
  end


  private
  #return fin accounts for sender and recipient. Also return error hash
  def self.find_accounts(sender, recipient)
    sender_fin_acc = FinancialAccount.find_account(sender)
    recipient_fin_acc = FinancialAccount.find_account(recipient)
    result_hash = if sender_fin_acc.nil? || recipient_fin_acc.nil?
                    {:result => false, :errors => ['Транзакция невозможна по техническим причинам попробуйте позже']}
                  else
                    {:result => true, :errors => []}
                  end
    [sender_fin_acc, recipient_fin_acc, result_hash]
  end

end