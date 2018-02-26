class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build
    rescue
      redirect_to root_path, warning: '申し訳ございません。お探しの質問は見つかりませんでした。'
  end

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question), success: '回答を作成しました。'
    else
      @question = Question.find(params[:question_id])
      render :new
    end
    rescue
      redirect_to root_path, warning: '申し訳ございません。お探しの質問は見つかりませんでした。'
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer)
          .permit(:body)
          .merge(question_id: params[:question_id])
  end
end
