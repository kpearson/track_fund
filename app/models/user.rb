class User < ActiveRecord::Base

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth["provider"], uid: auth["id"])
    user.first_name = auth["first_name"]
    user.gender     = auth["gender"]
    user.last_name  = auth["last_name"]
    user.link       = auth["link"]
    user.locale     = auth["locale"]
    user.name       = auth["name"]
    user.token      = auth["token"]
    user.save
    user
  end
end
