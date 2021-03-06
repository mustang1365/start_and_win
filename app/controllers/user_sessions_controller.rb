class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email_or_login], params[:password], params[:remember])
      if @user.admin?
        redirect_back_or_to(admin_root_path, :notice => 'Login successfull.')
      else
        redirect_back_or_to(:users, :notice => 'Login successfull.')
      end
    else
      flash.now[:alert] = "Login failed."
      render :action => "new"
    end
  end

  def destroy
    logout
    redirect_to root_path, :notice => 'Logged out!'
  end
end
