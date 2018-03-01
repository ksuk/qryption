class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @questions = Question.includes(:user).page(params[:page]).order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.includes(:user).page(params[:page]).order(created_at: :desc)
    rescue
      redirect_to root_path, warning: '申し訳ございません。お探しの質問は見つかりませんでした。'
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

  def question_params
    params.require(:question).permit(:body)
  end
end
