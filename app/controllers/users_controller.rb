class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @user = User.find(params[:id])
    rescue
      redirect_to root_path, alert: '申し訳ございません。お探しのユーザーは存在しませんでした。'
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path, alert: 'ご自身のアカウントのみ編集ができます。' unless @current_user == @user
    rescue
      redirect_to root_path, alert: '申し訳ございません。お探しのユーザーは存在しませんでした。'
  end

  def update
    @user = User.find(params[:id])
    redirect_to root_path, alert: 'ご自身のアカウントのみ編集ができます。' unless @current_user == @user
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end

    rescue
      redirect_to root_path, alert: '申し訳ございません。お探しのユーザーは存在しませんでした。'
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
