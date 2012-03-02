#encoding: utf-8
class FrontEnd::QuestionsController <  FrontEnd::ApplicationController
  before_filter(:only => [:show, :start_play, :process_results, :set_rating_and_finish]) { |c| c.find_model_or_404 Question }

  def index
    @questions = current_user.present? ? Question.active.available_for_user(current_user) : Question.active
    @lucky_question = @questions.order('RAND()').first
  end

  #after user press 'Play' button after reading conditions
  def start_play

  end

  #after user answer the question
  def process_results
    #TODO after F5 creates a new record => check and redirect(not render form) if user already set rating
    PlayResult.create(:user => current_user, :competition => @question, :answers => params[:answer],
                      :won => @question.variants.find_by_id(params[:answer]).try(:answer?))
    @rating = Rating.new
    render :set_rating_and_finish
  end

  #save question rating, process payment and finish
  #TODO send email to admin if payment failed
  #TODO pay amount depends on rating
  def set_rating_and_finish
    play_result = PlayResult.find_for_user(current_user, @question)
    rating = Rating.new(params[:rating])
    play_result.rating = rating
    if play_result.save &&
        play_result.update_column(:payed, true)
        @notice = 'Соревнование закнчилось. Пробуйте другие соревнования.'
    end
    redirect_to questions_path, :notice => @notice || 'Произошла ошибка при завершений соревнования. Администрация сайта уведомлена. Ошибка будет исправления. Приносим свои извинения.'
  end


end
