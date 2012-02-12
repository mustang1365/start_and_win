{-1 => 10000, -2 => 10000, -3 => 0}.each do |key, value|
  FinancialAccount.create(:user_id => key, :points_amount => value) if FinancialAccount.find_by_user_id(key).nil?
end