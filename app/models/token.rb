class Token < ActiveRecord::Base
  belongs_to :user

  def self.new_token(auth_token)
    token = Token.new
    token.token    = auth_token["access_token"]
    token.provider = "nation_builder"
    token.uid      = auth_token["user_id"]
    token.save
    token
  end
end
