if User.find_by_email('m3.developers@gmail.com').nil?
  User.create(:email => 'm3.developers@gmail.com',
              :login => 'm3_group',
              :password => 'm3_admin',
              :password_confirmation => 'm3_admin',
              :admin => true
              )
end

if User.find_by_email('test_player@test.tt').nil?
  user = User.create(:email => 'test_player@test.tt',
             :login => 'player',
             :password => 'player',
             :password_confirmation => 'player',
             :admin => false
             )
  user.iq_level = 80
  user.financial_account.points_amount = 1000
  user.save!
end

if User.find_by_email('cm_maker@test.tt').nil?
  user = User.create(:email => 'cm_maker@test.tt',
             :login => 'cm_maker',
             :password => 'cm_maker',
             :password_confirmation => 'cm_maker',
             :admin => false
             )
  user.iq_level = 90
  fin_account = user.financial_account
  fin_account.points_amount = 1000
  fin_account.save!
  user.save!
end