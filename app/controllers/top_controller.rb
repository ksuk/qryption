class TopController < ApplicationController
  def index
    return redirect_to root_path, alert: 'すでにログインしています。' if user_signed_in?
  end
end
