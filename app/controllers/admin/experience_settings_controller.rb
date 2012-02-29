class Admin::ExperienceSettingsController < Admin::ApplicationController
  def index
    @settings = ExperienceSetting.all
  end

  def update_all_settings
    #TODO validation
    if params[:settings].present? && params[:settings].any?
      params[:settings].each do |setting_id, setting_params|
        if (exp_setting = ExperienceSetting.find_by_id(setting_id)).present?
          exp_setting.update_attributes(setting_params)
        end
      end
      redirect_to admin_experience_settings_path
    else
      redirect_to admin_root_path, :notice => 'ERROR'
    end
  end
end
