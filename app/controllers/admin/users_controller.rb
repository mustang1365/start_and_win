class Admin::UsersController < Admin::AdminController

  def index
    if params[:admin].present?
      @users = User.admins
    else
      @users = User.not_admins
    end
  end

  def show

  end

  def toggle_user_active_status_users

  end

  def new
   @admin = User.new
   @roles = Role.admin
  end

  def create
      a =1
  end

end
