require 'pry'
require 'http'

response = HTTP.headers(
  'x-boiler-client-id': ENV["BOILER_CLIENT_ID"],
  'x-boiler-client-secret': ENV["BOILER_CLIENT_SECRET"]
).get(
  "https://boiler.ngrok.dev/api/gate/approve"
)

binding.pry
