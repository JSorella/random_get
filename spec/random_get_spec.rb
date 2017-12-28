require 'webmock/rspec'

describe RandomGet do
  let(:api_key) { "dbb7f816-b792-496e-ad56-990fc2b2bd7b" }
  let(:mocked_response) do
    {
      status: 200,
      body: { result: { random: { data: [6095] } } }.to_json
    }
  end
  let(:request_body_base) { described_class::REQUEST_BODY_BASE }
  let(:request_headers) { described_class::REQUEST_HEADERS }
  let(:request_uri) { described_class::REQUEST_URI }

  before(:each) do
    stub_request(:post, request_uri).
      with(body: hash_including(request_body_base), headers: request_headers).
      to_return(mocked_response)
  end

  context "when initialized with the default parameters" do
    subject { RandomGet.new api_key }

    it "calls the API once on each request" do
      2.times { subject.get }
      expect(WebMock).to have_requested(:post, request_uri).twice
    end
  end
end
