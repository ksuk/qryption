class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env["omniauth.auth"].except("extra")
    social_oauth = SocialOauth.where(provider: SocialOauth.providers[auth['provider']], uid: auth['uid']).first
    if current_user.present?
      # # 紐付け・認証更新処理
      # if social_oauth.present?
      #   if social_oauth.user == current_user
      #     # 更新
      #   else
      #     # 他のユーザーに紐付いているアカウントはダメ
      #   end
      # else
      #   current_social_oauth = current_user.social_oauths.where(provider: SocialOauth.providers[oauth['provider']])
      #   if current_social_oauth.present?
      #     # 既に紐付いている他の連携がある場合はダメ
      #   else
      #     # 新規紐付け
      #   end
      # end
    else
      # ログイン・サインアップ処理
      if social_oauth.present?
        # ログイン
        @user = social_oauth.user
      else
        # 登録
        @user = User.create_from_oauth(auth)
      end
    end

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.user_attributes"] = @user.attributes
      redirect_to new_user_registration_url
    end
  end
end
