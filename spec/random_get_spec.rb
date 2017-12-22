RSpec.describe RandomGet do
  it 'Has a version number' do
    expect(RandomGet::VERSION).not_to be nil
  end

  it 'Get method returns an Integer' do
  	random = RandomGet.new "dbb7f816-b792-496e-ad56-990fc2b2bd7b"

    expect(random.get).to be_a_kind_of(Integer)
  end
end
