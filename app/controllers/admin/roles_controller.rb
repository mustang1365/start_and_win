#encoding: utf-8
class Admin::RolesController < Admin::AdminController
  before_filter :find_role, :only => [:edit, :show, :update, :destroy]
  before_filter :set_permissions, :only =>[:edit,:update, :show]

  def index
    authorize!
    @roles = Role.all
  end

  def new
    @role = Role.new
    @permissions = Permission.where("permission_type = ?", Role::TYPES[0]).group_by { |per| per.group_name }
  end

  def create
    @role = Role.new(params[:role])
    @role.permissions = Permission.where("permission_type = ? AND id IN (?)", @role.role_type, params[:permissions_ids].split(','))
    if @role.save
      redirect_to roles_path, :notice => 'Роль успешно добавлена'
    else
      set_permissions(@role)
      render :action => :new
    end
  end

  def edit

  end

  def update
    @role.permissions = Permission.where("permission_type = ? AND id IN (?)", @role.role_type, params[:permissions_ids].split(','))
    if @role.update_attributes(params[:role])
      redirect_to roles_path, :notice => 'Роль успешно обновлена'
    else
      render :action => :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, :notice => 'Роль успешно удалена'
  end

  def show

  end


  def ajax_load_permissions
    @permissions = Permission.where("permission_type = ?", params[:role_type]).group_by { |per| per.group_name }
  end

  private

  def find_role
      redirect_to '/404.html' unless @role = Role.find_by_id(params[:id])
  end

  def set_permissions(role = nil)
    role = Role.find_by_id(params[:id]) if role.nil?
    @permissions = Permission.where("permission_type = ?", role.role_type).group_by { |per| per.group_name } if role
  end
end
