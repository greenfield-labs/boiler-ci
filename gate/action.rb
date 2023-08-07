require 'http'

HTTP.post(
  "https://boiler.ngrok.dev/api/gate",
  headers: {
    "BOILER_CLIENT_ID": ENV["BOILER_CLIENT_ID"],
    "BOILER_CLIENT_SECRET": ENV["BOILER_CLIENT_SECRET"]
  }
)
