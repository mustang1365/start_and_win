class UserProfileController < ApplicationController
  before_filter :find_profile

  def show

  end

  def edit
    set_set_variables_for_form
  end

  def update
    set_set_variables_for_form
  end

  private
  def find_profile
    redirect_to '/404' if (@profile = Profile.find_by_id(params[:id])).nil?
  end

  def set_set_variables_for_form
    @education_levels =  EducationLevel.all
    @categories = MainCategory.all
    @profile.model_to_main_categories.build if @profile.model_to_main_categories.empty?
  end
end
