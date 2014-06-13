require 'spec_helper'

describe Oembedder do
  it 'has a version number' do
    expect(Oembedder::VERSION).not_to be nil
  end

  context 'get vimeo' do
    it 'xml format' do
      oe = Oembedder.new
      response =  oe.get('http://vimeo.com/84828674', format: :xml)
      expect(response.title).to eq("The Xsjado Video - JEFF STOCKWELL")
    end

    it 'json format' do
      oe = Oembedder.new
      response =  oe.get('http://vimeo.com/84828674')
      expect(response.title).to eq("The Xsjado Video - JEFF STOCKWELL")
    end
  end

  context 'daily motion' do
    it 'get video' do
      oe = Oembedder.new
      url = 'http://www.dailymotion.com/video/x1nvvlo_20140412-%E5%B5%90%E3%81%AB%E3%81%97%E3%82%84%E3%81%8C%E3%82%8C-%E6%B0%B4%E5%8D%9C%E9%BA%BB%E7%BE%8E_lifestyle'
      response =  oe.get(url, format: :xml)
      expect(response.type).to eq('video')
    end
  end

  context 'youtube' do
    it 'get video' do
      oe = Oembedder.new
      url = 'http://www.youtube.com/watch?v=Qf60wknp4q0'
      response =  oe.get(url, format: :xml)
      expect(response.type).to eq('video')
    end
  end
end
