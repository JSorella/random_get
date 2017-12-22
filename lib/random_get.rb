require 'random_get/version'
require 'net/http'
require 'json'
require 'uri'


class RandomGet
  def initialize(api_key, min=0, max=9999)
    @api_key = api_key
    @min = min
    @max = max
  end
  
  def get   
    uri = URI("https://api.random.org/json-rpc/1/invoke")
    headers = {"Content-Type" => "application/json-rpc"}
    params = {params: {
                       apiKey: @api_key,
                       n: 1,
                       min: @min,
                       max: @max
                    },
            method: "generateIntegers",
            jsonrpc: "2.0",
            id: 1
            }
        
    # Create the HTTP objects
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri, headers)
    req.body = params.to_json
    
    body = JSON.parse(https.request(req).body)
    body['result']['random']['data'][0]
  end
end
