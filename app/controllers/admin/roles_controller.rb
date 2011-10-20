#encoding: utf-8
class Admin::RolesController <  Admin::AdminController
  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to roles_path, :notice => 'роль успешно добавлена'
    else
      render :action => :new
    end
  end
end
