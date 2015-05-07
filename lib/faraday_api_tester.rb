# TODO: Move this into test dir
require "faraday"

user_token = "cd0928c01847d6e7ad34a9dc55d2be082f625e178d154d4e8c9134478dafd681"

conn = Faraday.new("https://trackfund.nationbuilder.com")
conn.params = { "access_token" => user_token }
puts conn.get("/api/v1/pledges")
