class QuestionsController < ApplicationController
  before_action :set_question, only: :show
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @questions = Question.page(params[:page]).order(created_at: :desc)
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
      redirect_to question_path(@question), success: '質問を投稿しました。'
    else
      render :new
    end
  end

  private

  def set_question
    @question = Question.includes(:answers).find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
