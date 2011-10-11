class HomeController < ApplicationController
  def index
    if session[:success_registration]
      @after_registration = true
      session[:success_registration]= nil
    end
  end

end
