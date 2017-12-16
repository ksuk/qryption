class QuestionsController < UserApplicationController
  def show
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
