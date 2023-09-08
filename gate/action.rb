require 'http'
require 'pathname'

class Authentication
  def authorize!
    puts "Starting boiler token exchange"
    response = HTTP
      .headers(
        'content-type': 'application/json',
        'x-github-oidc-token': client_token
      )
      .post("https://boiler.ngrok.dev/api/github/authorize")

    puts "Token exchange ressults #{response.body}"
  end

  protected

  # client_token either comes from GitHub when running in an action,
  # or it can be read from disk for development purposes.
  def client_token
    @token ||= ENV["BOILER_LOCAL"] ? get_local_jwt : get_github_jwt
  end

  def get_local_jwt
    puts "Using local JWT"

    jwt_path = Pathname.pwd.join("../../backend/.jwt")

    File.read(jwt_path).chomp
  end

  def get_github_jwt
    puts "Using GitHub JWT"

    exchange = HTTP.headers(
      "Authorization": "Bearer #{ENV["ACTIONS_ID_TOKEN_REQUEST_TOKEN"]}"
    ).get(
      ENV["ACTIONS_ID_TOKEN_REQUEST_URL"]
    )

    exchange_body = exchange.body.to_s

    JSON.parse(exchange_body)['value']
  end
end

def run
  auth = Authentication.new.authorize!

  response = HTTP.headers(
    'content-type': 'application/json',
    'Authentication': auth.token
  ).get(
    "https://boiler.ngrok.dev/api/gate/approve"
  )

  puts response.body
end

if ARGV.empty?
  run
else
  require 'pry';
  binding.pry
end
