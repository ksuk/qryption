class AnswersController < UserApplicationController
  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question)
    else
      redirect_to question_path(@answer.question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :body, :question_id)
  end
end
