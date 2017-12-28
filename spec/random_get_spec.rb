require 'webmock/rspec'


RSpec.describe RandomGet do

  let(:random) { RandomGet.new "dbb7f816-b792-496e-ad56-990fc2b2bd7b" }
  let(:expected_response_body) do
    {
      jsonrpc: "2.0",
      result: {
        random: {
          data: [6095],
          completionTime: "2017-12-27 15:19:23Z"
        },
        bitsUsed: 13,
        bitsLeft: 249961,
        requestsLeft: 997,
        advisoryDelay: 1440
      },
      id: 1
    }.to_json
  end

  context 'one' do
    it 'Has a version number' do
      expect(RandomGet::VERSION).not_to be nil
    end
  end


  

  it 'Get method returns an Integer' do
    stub_request(:post, "https://api.random.org/json-rpc/1/invoke").
         with(body: "{\"params\":{\"apiKey\":\"dbb7f816-b792-496e-ad56-990fc2b2bd7b\",\"n\":1,\"min\":0,\"max\":9999},\"method\":\"generateIntegers\",\"jsonrpc\":\"2.0\",\"id\":1}",
              headers: {'Content-Type'=>'application/json-rpc'}).
         to_return(status: 200, body: expected_response_body, headers: {})

    expect(random.get).to be_a_kind_of(Integer)
  end



end
