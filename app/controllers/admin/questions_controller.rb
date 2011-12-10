#encoding: utf-8
class Admin::QuestionsController < Admin::ApplicationController
  before_filter :find_question, :only => [:show, :edit, :update, :destroy]
  def index
    @questions = Question.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  def new
    @question = Question.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    @question = Question.new(params[:question])
    respond_to do |format|
      if @question.save
        format.html { redirect_to admin_questions_path, notice: 'Question was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to admin_questions_path, notice: 'Question was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
    end
  end

  private

  def find_question
   redirect_to admin_main_categories_path(:notice => "Запись не найдена") if (@question = Question.find_by_id(params[:id])).nil?
  end
end
