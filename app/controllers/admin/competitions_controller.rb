#encoding: utf-8
class Admin::CompetitionsController < Admin::ApplicationController
  before_filter :find_competition, :only => [:show, :edit, :update, :destroy]
  def index
    @competitions = Competition.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @competition }
    end
  end

  def new
    @competition = Competition.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    @competition = Competition.new(params[:competition])
    respond_to do |format|
      if @competition.save
        format.html { redirect_to admin_competitions_path, notice: 'Competition was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @competition.update_attributes(params[:competition])
        format.html { redirect_to admin_competitions_path, notice: 'Competition was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @competition.destroy
    respond_to do |format|
      format.html { redirect_to competitions_url }
    end
  end

  private

  def find_competition
   redirect_to admin_competitions_path(:notice => "Запись не найдена") if (@competition = Competition.find_by_id(params[:id])).nil?
  end
end
