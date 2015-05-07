class User < ActiveRecord::Base
  has_many :tokens

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

  def nation_token
    binding.pry
    token_object = tokens.find_by(provider: "nation_builder")
    token_object.token if token_object
  end

  def nbuilder
    @nbuilder ||= NationBuilderService.new(
      nation_token: nation_token,
      app_secret: ENV.fetch('NATION_SECRET'),
      app_id:     ENV.fetch('NATION_APPID'),
    )
  end
end
