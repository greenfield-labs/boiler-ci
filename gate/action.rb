require 'pry'
require 'http'
require 'pathname'

if ENV["BOILER_LOCAL"]
  puts "Using local Boiler JWT"

  jwt_path = Pathname.pwd.join("../../backend/jwt")
  jwt_contents = File.read(jwt_path).chomp
else
  puts "Using GitHub JWT exchange"

  exchange = HTTP.headers(
    "Authorization": "Bearer #{ENV["ACTIONS_ID_TOKEN_REQUEST_TOKEN"]}"
  ).get(
    ENV["ACTIONS_ID_TOKEN_REQUEST_URL"]
  )

  puts "EXCHANGE: #{exchange.code}"
  exchange_body = exchange.body.to_s
  jwt_contents = JSON.parse(exchange_body)['value']
end

response = HTTP.headers(
  'content-type': 'application/json',
  'x-github-oidc-token': jwt_contents
).get(
  "https://boiler.ngrok.dev/api/gate/approve"
)

puts response.body
