#encoding: utf-8
class ProfilesController < ApplicationController
  def show
   @user_to_show = User.find(params[:id])
  end

  def edit
    @user_to_edit = current_user
  end

  def update
    @user_to_edit = User.find(Profile.find(params[:id]).user.id)
    if User.last.update_attributes(params[:user])
      flash[:notice] = 'Профиль успешно обновлен'
      redirect_to :action => :show, :id => @user_to_edit.id
    else
      render :action => :edit
    end
  end
end
