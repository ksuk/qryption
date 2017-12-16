class WelcomeController < ApplicationController
  def index
    return render 'unlogin' unless current_user
    @questions_top_5 = Question.top_5
    @questions = Question.all
  end
end
