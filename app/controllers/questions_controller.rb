class QuestionsController < UserApplicationController
  def new
    @question = current_user.questions.build
  end

  def create
  end
end
