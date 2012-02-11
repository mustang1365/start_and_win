#encoding: utf-8
class Admin::QuestionsController < Admin::ApplicationController
  before_filter :find_question, :only => [:show, :edit, :update, :destroy]
  before_filter :set_variables_for_form, :only => [:new, :edit, :update, :create]
  before_filter :set_selected_category, :only => [:edit, :update]
  include QuestionControllerLib

  def index
    @questions = Question.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @question = Question.new
    @question.build_model_to_main_category
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @question = Question.new
    @question.attributes = params[:question]
    @selected_category = @question.model_to_main_category.main_category
    @selected_sub_categories = @question.model_to_main_category.model_to_main_category_to_sub_categories.map(&:sub_category_id)
    respond_to do |format|
      if @question.save
        format.html { redirect_to admin_questions_path, notice: 'Question was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
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

  def multiple_upload
    if params[:upload_file_id].present? && (file = PrivateFile.find_by_id(params[:upload_file_id])).present?
      Question.create_from_hash(YAML::load(File.open(file.file_content_url)))
      @success = true
    end
  end
end
