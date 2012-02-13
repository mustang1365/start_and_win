class FrontEnd::QuestionsController <  FrontEnd::ApplicationController
  before_filter(:only => [:show]) { |c| c.find_model_or_404 Question }

  def index
    @questions = current_user.present? ? Question.active.available_for_user(current_user) : Question.active
  end

  def show

  end

  #after user press 'Play' button near question
  def start_play

  end


end
