#encoding: utf-8
module QuestionControllerLib
 #Common question methods for controller
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_questions_url }
    end
  end

  private

  def find_question
    redirect_to root_path_for(current_user) , :notice => "Запись не найдена" if (@question = Question.find_by_id(params[:id])).nil?
  end

  def set_variables_for_form
    @categories = MainCategory.all
  end

  def set_selected_category
    @selected_category = @question.main_category
    @selected_sub_categories = @question.sub_categories.map(&:id)
  end
end