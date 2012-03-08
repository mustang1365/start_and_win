namespace :payment do
  desc "Reset site found and test user balances"
  task :reset_balances => :environment do
    player = User.find_by_email('test_player@test.tt')
    if player
      player.iq_level = 80
      fin_account = player.financial_account
      fin_account.points_amount = 1000
      fin_account.reserved_points = 0
      fin_account.save!
      player.save!
    end
    maker = User.find_by_email('cm_maker@test.tt')
    if maker
      maker.iq_level = 90
      fin_account = maker.financial_account
      fin_account.points_amount = 1000
      fin_account.reserved_points = 0
      fin_account.save!
      maker.save!
    end

    %W(-1 -2 -3).each do |user_id|
      if (fin_account = FinancialAccount.find_by_user_id(user_id)).present?
        fin_account.points_amount = 0
        fin_account.reserved_points = 0
        fin_account.save!
      end
    end

    Question.all.each do |question|
      if (fin_account = question.financial_account).present?
        fin_account.points_amount = question.play_condition.points_to_play
        fin_account.save!
      end
    end
  end
end