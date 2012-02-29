#encoding: utf-8
class Cabinet::QuestionsController < Cabinet::ApplicationController
  before_filter :find_question, :only => [:show, :close_question]
  before_filter :set_variables_for_form, :only => [:new, :create]
  before_filter :require_iq, :only => [:new, :create]

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
    @question = Question.new(:user => current_user)
    @question.build_model_to_main_category
    @question.build_play_condition
  end

  def create
    @question = Question.new
    @question.attributes = params[:question]
    if @question.save
      redirect_to cabinet_questions_path, :notice => 'Вопрос успешно создан.'
    else
      @selected_category = @question.model_to_main_category.main_category
      @selected_sub_categories = @question.model_to_main_category.model_to_main_category_to_sub_categories.map(&:sub_category_id)
      render :action => :new
    end
  end

  def close_question
    @question.update_column(:status, Question::STATUSES_HASH[:close])
    redirect_to cabinet_questions_path
  end
end
