require 'spec_helper'

describe Oembedder::Provider do
  before do
    @vimeo = Oembedder::Provider.new
    @vimeo.set_endpoint('http://vimeo.com/api/oembed.json')
    @vimeo.set_schemes(
    ['http://vimeo.com/*',
      'http://vimeo.com/channels/*/*',
      'http://vimeo.com/groups/*/videos/*'])
  end

  it 'match scheme' do
    expect(@vimeo.match_scheme? 'http://vimeo.com/84828674').to be true
    expect(@vimeo.match_scheme? 'http://vimeo.com/84828674').to be true
    expect(@vimeo.match_scheme? 'http://vimeo.com/channels/84828674/1234').to be true
    expect(@vimeo.match_scheme? 'http://vimeo.com/groups/1231/videos/121321/').to be true
  end

  it 'not match scheme' do
    expect(@vimeo.match_scheme? 'http://vimeo.com/failed/831312312/').to be_falsy
    expect(@vimeo.match_scheme? 'http://vimeo.com1/12321312/').to be_falsy
    expect(@vimeo.match_scheme? 'http://vimeo.com/121312/failed').to be_falsy
  end

end
