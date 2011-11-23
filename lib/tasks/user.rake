namespace :users do
  desc "Create default admin user"
  task :create_admin => :environment do
      User.create(:email => "m3.developers@gmail.com",:login => "m3_group",
                  :password => "m3_admin",:password_confirmation => "m3_admin", :admin =>true)
  end
end