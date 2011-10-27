#encoding: utf-8
class ProfilesController < ApplicationController
  after_filter :necessary_actions

  def show
    @profile = User.find_by_id(params[:id]).try(:profile)
  end

  def edit
    @profile = current_user.profile
    @profile.build_associations_if_empty
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:notice] = 'Профиль успешно обновлен'
      redirect_to :action => :show, :id => @profile.id
    else
      @profile.build_associations_if_empty
      render :action => :edit
    end
  end

  def necessary_actions
    a = 1
  end
end
