#encoding: utf-8
class Cabinet::QuestionsController < Cabinet::ApplicationController
  before_filter :find_question, :only => [:show, :edit, :update, :destroy]
  before_filter :set_variables_for_form, :only => [:new, :edit, :update, :create]
  before_filter :set_selected_category, :only => [:edit, :update]
  before_filter :require_iq, :only => [:new, :update, :edit, :create]

  include QuestionControllerLib

  def index
    @questions = case params[:listing_type]
                   when 'inactive'
                     current_user.questions.inactive
                   else
                     current_user.questions.active
                 end
  end

  def new
    @question = current_user.questions.build
    @question.build_model_to_main_category
    @question.build_play_condition
  end

  def create
    @question = Question.new
    @question.attributes = params[:question]
    if @question.save
      current_user.questions << @question
      redirect_to cabinet_questions_path, :notice => 'Вопрос успешно создан.'
    else
      @selected_category = @question.model_to_main_category.main_category
      @selected_sub_categories = @question.model_to_main_category.model_to_main_category_to_sub_categories.map(&:sub_category_id)
      render :action => :new
    end
  end
end
