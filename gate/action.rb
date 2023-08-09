require 'pry'
require 'http'

response = HTTP.headers(
  'x-boiler-client-id': ENV["BOILER_CLIENT_ID"],
  'x-boiler-client-secret': ENV["BOILER_CLIENT_SECRET"],
  'x-github-oidc-url': ENV["ACTIONS_ID_TOKEN_REQUEST_URL"],
  'x-github-oidc-token-request-token': ENV["ACTIONS_ID_TOKEN_REQUEST_TOKEN"]
).get(
  "https://boiler.ngrok.dev/api/gate/approve"
)

puts "response code: #{response.code}"

puts "ENV: #{ENV.to_h}"

puts response.body
