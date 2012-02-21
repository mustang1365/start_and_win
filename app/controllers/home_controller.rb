class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    #TODO add search,pagination and select main news
   @news_points = NewsPoint.all
   @main_news_point = NewsPoint.first
  end

end
