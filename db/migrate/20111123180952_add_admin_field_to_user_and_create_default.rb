class AddAdminFieldToUserAndCreateDefault < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean, :default => false
    User.create(:email => "m3.developers@gmail.com",:login => "m3_group",:password => "m3_admin",:password_confirmation => "m3_admin", :admin =>true)
  end

  def self.down
    remove_column :users, :admin
  end
end
