class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
  end

  def edit
  end

  def update
  end
end
