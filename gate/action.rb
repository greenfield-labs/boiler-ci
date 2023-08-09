require 'pry'
require 'http'

exchange = HTTP.headers(
  "Authorization": "Bearer #{ENV["ACTIONS_ID_TOKEN_REQUEST_TOKEN"]}"
).get(
  ENV["ACTIONS_ID_TOKEN_REQUEST_URL"]
)

puts "EXCHANGE: #{exchange.code}"
exchange_body = exchange.body

response = HTTP.headers(
  'x-boiler-client-id': ENV["BOILER_CLIENT_ID"],
  'x-boiler-client-secret': ENV["BOILER_CLIENT_SECRET"],
  'x-boiler-exchange': exchange_body,
  'x-github-oidc-token': JSON.parse(exchange_body)['value']
).get(
  "https://boiler.ngrok.dev/api/gate/approve"
)

puts "ENV: #{ENV.to_h}"

puts response.body
