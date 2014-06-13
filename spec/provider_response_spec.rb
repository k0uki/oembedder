require 'spec_helper'

describe Oembedder::ProviderResponse do
  it 'parse response' do
    response = {"type"=>"video", "version"=>"1.0", "provider_name"=>"Vimeo"}
    pr = Oembedder::ProviderResponse.new(format: :json)
    pr.parse(response)

    expect(pr.type).to eq('video')
    expect(pr.provider_name).to eq('Vimeo')

    expect {pr.type1}.to raise_error(NoMethodError)
  end

  it 'provider error' do
    oe = Oembedder.new
    response =  oe.get('http://vimeo.com/sfds121312')
    expect(response.has_error).to be true

    response2 =  oe.get('http://vimeo.com/84828674')
    expect(response2.has_error).to be_falsy
  end

end
