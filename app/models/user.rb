class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:twitter]

  has_many :social_oauths, dependent: :destroy
  has_many :questions, dependent: :destroy

  def self.create_from_oauth(auth)
    user = User.new
    social_oauth = user.social_oauths.build
    social_oauth.build_from_oauth(auth)
    user.email = "#{auth['uid']}@#{auth['provider']}.com"
    user.password = SecureRandom.urlsafe_base64
    user.save!
    user
  end
end
