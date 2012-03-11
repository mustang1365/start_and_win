#encoding: utf-8
class FrontEnd::QuestionsController <  FrontEnd::ApplicationController
  before_filter(:only => [:show, :start_play, :process_results, :set_rating_and_finish]) { |c| c.find_model_or_404 Question }

  def index
    @questions = current_user.present? ? Question.active.available_for_user(current_user) : Question.active
    @lucky_question = @questions.order('RAND()').first
  end

  #after user press 'Play' button after reading conditions
  def start_play
    #frozen user's money
    unless (result = PaymentSystem.process_payment_to_temp_fund(current_user, @question.play_condition.participation_points ))[:result]
       redirect_to questions_path, :alert => result[:errors].join('<br/>').html_safe
    end
  end

  #after user answer the question
  def process_results
    if PlayResult.find_for_user(current_user, @question).empty?
      PlayResult.create(:user => current_user, :competition => @question, :answers => params[:answer],
                            :won => @question.variants.find_by_id(params[:answer]).try(:answer?))
    end
    @rating = Rating.new
    render :set_rating_and_finish
  end

  #save question rating, process payment and finish
  #TODO send email to admin if payment failed
  def set_rating_and_finish
    play_result = PlayResult.find_for_user(current_user, @question)
    rating = Rating.new(params[:rating])
    play_result.rating = rating
    if rating.save
      @notice = if (result = PaymentSystem.pay_for_competition(current_user, @question, rating, play_result.won?))[:result]
          play_result.update_attributes({:rating => rating, :payed => true})
          'Спасибо за участие. Попробуйте другие соревнования.'
        else
          result[:errors].join('<br/>').html_safe
        end
    end
    redirect_to questions_path, :notice => @notice || 'Произошла ошибка при завершений соревнования. Администрация сайта уведомлена. Ошибка будет исправления. Приносим свои извинения.'
  end


end
