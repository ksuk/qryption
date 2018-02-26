class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[twitter]

  mount_uploader :image, ImageUploader

  has_many :social_oauths, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy

  with_options on: :update_info do |update|
    update.validates :name, presence: true
    update.validates :email, presence: true
  end

  def self.create_from_oauth(auth)
    user = User.new
    social_oauth = user.social_oauths.build
    social_oauth.build_from_oauth(auth)
    user.email = "#{auth['uid']}@#{auth['provider']}.com"
    user.password = SecureRandom.urlsafe_base64
    user.remote_image_url = auth.info.image
    user.name = auth.info.name
    user.website = auth.info.urls.Website if auth.info.urls.Website.present?
    user.save!
    user
  end
end
