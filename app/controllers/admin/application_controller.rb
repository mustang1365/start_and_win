#encoding: utf-8
class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_filter :require_admin

  def require_admin
    redirect_to '/', :notice => "Что бы иметь доступ к данному разделу сайта зайдите как администратор" unless current_user.present? && current_user.admin?
  end

end
