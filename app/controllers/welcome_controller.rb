class WelcomeController < ApplicationController
  def index
    return render 'unlogin' unless current_user

    @questions = Question.all
  end
end
