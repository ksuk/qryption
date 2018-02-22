class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(
            :name,
            :email,
            :profile,
            :website,
            :image)
  end
end
