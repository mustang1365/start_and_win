class Admin::AdminSharedController < ApplicationController

  def load_subcategories
    if params[:category_id].present? && params[:model_type] &&
        (@category = MainCategory.find_by_id(params[:category_id])).present?
      @model_type = params[:model_type]
      @success = true
    end
  end

end
