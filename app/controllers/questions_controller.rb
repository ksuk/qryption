class QuestionsController < UserApplicationController
  before_action :set_question, only: :show
  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def show
    @answers = @question.answers
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

  private

  def set_question
    @question = Question.includes(:answers).find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
