#encoding: utf-8
class Admin::DifficultyLevelSettingsController < Admin::ApplicationController

  def index
    @difficulty_levels = DifficultyLevel.all
    @difficulty_levels.each do |level|
      level.create_difficulty_level_setting_if_need
    end
  end

  def update_all_settings
    if params[:levels].present? && params[:levels].any?
      params[:levels].each do |level_id, level_params|
        if (level = DifficultyLevel.find_by_id(level_id)).present?
          level.difficulty_level_setting.update_attributes(level_params['difficulty_level_setting'])
        end
      end
      redirect_to admin_difficulty_level_settings_path
    else
      redirect_to admin_root_path, :notice => 'ERROR'
    end
  end
end
