class ApplicationController < ActionController::Base
  include AuthorizeMethods

  protect_from_forgery
  before_filter :set_user_to_log_in
  rescue_from AccessException do |exception|
    flash[:error] = "You don't have permissions to access this page."
    redirect_to '/'
  end

  #set user for left column form
  def set_user_to_log_in
    @user = User.new  if current_user.nil?
  end

end

