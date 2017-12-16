class SocialOauth < ApplicationRecord
  belongs_to :user

  enum provider: { twitter: 10 }

  def build_from_oauth(auth)
    if auth['provider'] == "twitter"
      self.provider = SocialOauth.providers[auth['provider']]
      self.uid = auth['uid']
      credentials = auth['credentials']
      self.access_token = credentials['token']
      self.refresh_token = credentials['secret']
    end
  end
end
