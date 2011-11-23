#encoding: utf-8
class Admin::NewsPointsController < Admin::ApplicationController
  def index
    @news_points = NewsPoint.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @news_point = NewsPoint.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @news_point = NewsPoint.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @news_point = NewsPoint.find(params[:id])
  end

  def create
    @news_point = NewsPoint.new(params[:news_point])

    respond_to do |format|
      if @news_point.save
        format.html { redirect_to admin_news_points_url, notice: 'Новость успешно создана.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @news_point = NewsPoint.find(params[:id])
    respond_to do |format|
      if @news_point.update_attributes(params[:news_point])
        format.html { redirect_to admin_news_point_path, notice: 'Новость успешно отредактирована.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @news_point = NewsPoint.find(params[:id])
    @news_point.destroy

    respond_to do |format|
      format.html { redirect_to admin_news_points_url, notice: 'Новость успешно удалена.' }
      format.json { head :ok }
    end
  end
end
