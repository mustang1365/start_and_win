#Plese place short description of methods here:
###############################################
#require_iq - check iq > 0
################################################
class ApplicationController < ActionController::Base
  include UrlsHelper
  protect_from_forgery

  #redirect back with flash notice if user iq level is NULL
  #usefull for actions such as create new question etc
  def require_iq
     redirect_back_or_to root_path_for(current_user) if  current_user.iq_level <= 0 && !current_user.admin?
  end

  def find_model_or_404(model, param = 'id')
     redirect_to '/404' if instance_variable_set("@#{model.to_s.underscore}", model.find_by_id(params[param.to_sym])).nil?
  end
end
