class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user_to_log_in

  #set user for left column form
  def set_user_to_log_in
    @user = User.new  if current_user.nil?
  end

end
