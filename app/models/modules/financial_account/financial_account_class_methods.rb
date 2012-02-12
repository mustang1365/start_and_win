#encoding: utf-8
#FinancialAccount.find_account(User.first) - returns user's fin account
module Modules::FinancialAccount::FinancialAccountClassMethods
  def self.included(base)
    base.class_eval do
      #find fin account for user. You can pass user as model or as id
      #example:
      #FinancialAccount.find_account(User.first) - returns user's fin account
      #FinancialAccount.find_account(-1) - return  fin account for ADMIN_FUND
      def self.find_account(user)
        if user.instance_of?(User)
          user.admin? ?  FinancialAccount.find_by_user_id(FinancialAccount::ADMIN_FUND[:user_id])  : user.financial_account
        else
          FinancialAccount.find_by_user_id(user)
        end
      end
    end
  end
end
