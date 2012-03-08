#encoding: utf-8
class Admin::RatingRateSettingsController < Admin::ApplicationController

  def index
    @rates = RatingRate.all
  end

  def update_all_settings
    #TODO validation
    if params[:rates].present? && params[:rates].any?
      params[:rates].each do |rate_id, rate_params|
        if (rate = RatingRate.find_by_id(rate_id)).present?
          rate.update_attributes(rate_params)
        end
      end
      redirect_to admin_rating_rate_settings_path
    else
      redirect_to admin_root_path, :notice => 'ERROR'
    end
  end
end
