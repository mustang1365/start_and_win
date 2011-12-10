#encoding: utf-8
class Admin::MainCategoriesController < Admin::ApplicationController
  before_filter :find_category, :only => [:show, :edit, :update, :destroy]

  def index
    @main_categories = MainCategory.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @main_category = MainCategory.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    @main_category = MainCategory.new(params[:main_category])

    respond_to do |format|
      if @main_category.save
        format.html { redirect_to admin_main_categories_path, notice: 'Main category was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @main_category = MainCategory.find(params[:id])

    respond_to do |format|
      if @main_category.update_attributes(params[:main_category])
        format.html { redirect_to admin_main_categories_path, notice: 'Main category was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @main_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_main_categories_path }
    end
  end

  private

  def find_category
   redirect_to admin_main_categories_path(:notice => "Запись не найдена") if (@main_category = MainCategory.find_by_id(params[:id])).nil?
  end
end
