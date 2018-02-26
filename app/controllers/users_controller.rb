class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @user = User.find(params[:id])
    rescue
      redirect_to root_path, alert: '申し訳ございません。お探しのユーザーは存在しませんでした。'
  end

  def edit
    @user = User.find(params[:id])
    return redirect_to root_path, alert: 'ご自身のアカウントのみ編集ができます。' unless current_user == @user
    rescue
      redirect_to root_path, alert: '申し訳ございません。お探しのユーザーは存在しませんでした。'
  end

  def update
    @user = User.find(params[:id])
    return redirect_to root_path, alert: 'ご自身のアカウントのみ編集ができます。' unless current_user == @user
    @user.attributes = user_params
    if @user.save(context: :update_info)
      redirect_to user_path(current_user), success: 'ユーザー情報を更新しました。'
    else
      render :edit
    end

    rescue
      redirect_to root_path, alert: '申し訳ございません。お探しのユーザーは存在しませんでした。'
  end

  def edit_password
    @user = User.find(params[:id])
    return redirect_to root_path, alert: 'ご自身のアカウントのみ編集ができます。' unless current_user == @user
    rescue
      redirect_to root_path, alert: '申し訳ございません。お探しのユーザーは存在しませんでした。'
  end

  def update_password
    @user = User.find(params[:id])
    return redirect_to root_path, alert: 'ご自身のアカウントのみ編集ができます。' unless current_user == @user
    if @user.update_with_password(user_password_params)
      bypass_sign_in(@user)
      redirect_to user_path(current_user), success: 'パスワードを更新しました。'
    else
      render :edit_password
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

  def user_password_params
    params.require(:user)
          .permit(
            :current_password,
            :password,
            :password_confirmation)
  end
end
