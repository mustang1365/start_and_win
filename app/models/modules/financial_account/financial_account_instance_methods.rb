#encoding: utf-8
#decrease_balance - decrease points amount return hash{:result => true/false, :errors => []}
#increase_balance - increase points amount return hash{:result => true/false, :errors => []}
module Modules::FinancialAccount::FinancialAccountInstanceMethods
  def self.included(base)
    base.class_eval do
      #decrease points amount return hash{:result => true/false, :errors => []}
      def decrease_balance(amount)
        return {:result => false, :errors => ['Недостаточно средств']} if self.points_amount.to_f < amount.to_f
        self.points_amount -= amount.to_f
        self.save!
        {:result => true, :errors => []}
      end

      #increase points amount return hash{:result => true/false, :errors => []}
      def increase_balance(amount)
        #return {:result => false, :errors => ['Недостаточно средств']} if self.points_amount.to_f < amount.to_f
        self.points_amount += amount.to_f
        self.save!
        {:result => true, :errors => []}
      end
    end
  end
end
