class NationRequestHeaders < Faraday::Middleware
  def call(env)
    binding.pry
    env[:request_headers]["user_token"] = RequestStore.store[:user_token]
    env[:request_headers]["app_secret"] = ENV.fetch('NATION_APPID')
    env[:request_headers]["app_secret"] = ENV.fetch('NATION_SECRET')
    @app.call(env)
  end
end
