class FrontEnd::QuestionsController <  FrontEnd::ApplicationController
  before_filter(:only => [:show, :start_play, :process_results, :set_rating_and_finish]) { |c| c.find_model_or_404 Question }

  def index
    @questions = current_user.present? ? Question.active.available_for_user(current_user) : Question.active
    @lucky_question = @questions.order('RAND()').first
  end

  def show

  end

  #after user press 'Play' button after reading conditions
  def start_play

  end

  #after user answer the question
  def process_results
    PlayResult.create(:user => current_user, :competition => @question, :answers => params[:answer],
                      :won => @question.variants.find_by_id(params[:answer]).try(:answer?))
    @rating = Rating.new
    render :set_rating_and_finish
  end

  #save question rating, process payment and finish
  def set_rating_and_finish

  end


end
