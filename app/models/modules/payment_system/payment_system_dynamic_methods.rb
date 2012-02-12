#encoding: utf-8
module Modules::PaymentSystem::PaymentSystemDynamicMethods
  #generate methods for transfer points from special funds to user's fin accounts
  #Method names:
  #process_payment_from_admin - process payment from admin fin account to user
  #process_payment_from_site - process payment from site fin account to user
  #process_payment_from_temp_fund - process payment from temp fund fin account to user
  ::FinancialAccount::FUNDS.each do |fund|
    define_method "process_payment_from_#{fund[:method_name]}" do |recipient, amount|
      PaymentSystem.process_payment(fund[:user_id], recipient, amount)
    end
  end

  #generate methods for transfer points from special funds to user's fin accounts
  #Method names:
  #process_payment_to_admin - process payment to admin fin account from user
  #process_payment_to_site - process payment to site fin account from user
  #process_payment_to_temp_fund - process payment to temp fund fin account from user
  ::FinancialAccount::FUNDS.each do |fund|
    define_method "process_payment_to_#{fund[:method_name]}" do |sender, amount|
      PaymentSystem.process_payment(sender, fund[:user_id], amount)
    end
  end

end