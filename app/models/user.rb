class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :email, :presence => true, :uniqueness => true, :format => { :with => /^[a-zA-Z](([.]?([a-zA-Z0-9_-]+))*)?@([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,4}$/}
  validates :login, :presence => true
  validates :password, :presence => {:on => :create}
  validates :password, :confirmation => {:message => "should match confirmation"}, :length => {:minimum => 6, :message => "password must be at least 6 characters long"}, :if => :password

end
