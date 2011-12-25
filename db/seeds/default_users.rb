if User.find_by_email('m3.developers@gmail.com').nil?
  User.create(:email => 'm3.developers@gmail.com',
              :login => 'm3_group',
              :password => 'm3_admin',
              :password_confirmation => 'm3_admin',
              :admin => true
              )
end

if User.find_by_email('test_site@test_site.tt').nil?
  User.create(:email => 'test_site@test_site.tt',
              :login => 'test_site',
              :password => 'test_site',
              :password_confirmation => 'test_site',
              :admin => false
              )
end