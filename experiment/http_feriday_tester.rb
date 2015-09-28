require "faraday"

conn = Faraday.new(:url => "http://facebook.com") do |faraday|
  faraday.request   :url_encoded
  faraday.response  :logger
  faraday.params = { client_id: '1439156779728629',
                     redirect_uri: "http://localhost:3000/auth"
                   }
  faraday.adapter   Faraday.default_adapter
end

response = conn.get "/dialog/oauth"
