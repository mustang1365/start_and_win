#encoding: utf-8
#Plese place short description of methods here:
###############################################
#require_iq - check iq > 0
#find_model_or_404 - find model for actions or redirect to 404 if not found
################################################
class ApplicationController < ActionController::Base
  NEED_USER_ACTIONS = {:questions => [:start_play, :process_results, :set_rating_and_finish]}

  include UrlsHelper
  include GeneralHelper
  protect_from_forgery
  before_filter :require_user

  #redirect back with flash notice if user iq level is NULL
  #usefull for actions such as create new question etc
  def require_iq
     redirect_back_or_to root_path_for(current_user) if  current_user.iq_level <= 0 && !current_user.admin?
  end

  #find model for actions or redirect to 404 if not found
  #model should be class variable
  def find_model_or_404(model, param = 'id')
     redirect_to '/404' if instance_variable_set("@#{model.to_s.underscore}", model.find_by_id(params[param.to_sym])).nil?
  end

  #redirect '/' if action need user, but user not log in
  def require_user
    if !current_user &&  NEED_USER_ACTIONS[controller_name.to_sym].present? &&
        (NEED_USER_ACTIONS[controller_name.to_sym].include?(action_name.to_sym) || NEED_USER_ACTIONS[controller_name.to_sym].include?(:all))
      redirect_to '/', :notice => "Вы должны быть зарегистрированным пользователем. Войдите или зарегистрируйтесь"
    end
  end
end
