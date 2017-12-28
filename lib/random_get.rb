require 'random_get/version'
require 'net/http'
require 'json'

class RandomGet
  REQUEST_BODY_BASE = {
    method: "generateIntegers".freeze,
    jsonrpc: "2.0".freeze,
    id: 1
  }.freeze
  REQUEST_HEADERS = { "Content-Type".freeze => "application/json".freeze }.freeze
  REQUEST_URI = URI("https://api.random.org/json-rpc/1/invoke".freeze).freeze

  def initialize(api_key, min=0, max=9999)
    @api_key = api_key
    @min = min
    @max = max
  end

  def get   
    uri = REQUEST_URI
    headers = REQUEST_HEADERS
    params = REQUEST_BODY_BASE.merge({
      params: {
        n: 1,
        apiKey: @api_key,
        min: @min,
        max: @max
      }
    })

    # Create the HTTP objects
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri, headers)
    req.body = params.to_json
    
    body = JSON.parse(https.request(req).body)
    body['result']['random']['data'][0]
  end
end
