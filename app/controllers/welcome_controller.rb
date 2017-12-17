class WelcomeController < ApplicationController
  def index
    @question = Question.all
  end
end
