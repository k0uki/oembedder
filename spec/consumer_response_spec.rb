require 'spec_helper'

describe Oembedder::ConsumerRequest do
  it 'create urlparams' do

    cr = Oembedder::ConsumerRequest.new('yahoo.co.jp', maxwidth:1234, maxheight:555, format: :json)
    expect(cr.urlparams).to eq('?url=yahoo.co.jp&maxwidth=1234&maxheight=555')
  end
end
