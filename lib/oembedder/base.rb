module Oembedder
  class Base
    attr_accessor :providers

    def self.setup
      oembed = Base.new
      oembed.providers << create_vimeo
      oembed.providers << create_dailymotion
      oembed.providers << create_youtube
      oembed
    end

    def self.create_vimeo
      vimeo = Provider.new
      vimeo.set_endpoint('http://vimeo.com/api/oembed.json')
      vimeo.set_schemes(
      ['http://vimeo.com/*',
        'http://vimeo.com/channels/*/*',
        'http://vimeo.com/groups/*/videos/*'])
      vimeo
    end

    def self.create_dailymotion
      dm = Provider.new(format_type: 'querystring')
      dm.set_endpoint('http://www.dailymotion.com/services/oembed')
      dm.set_schemes(['http://www.dailymotion.com/video/*'])
      dm
    end

    def self.create_youtube
      youtube = Provider.new(format_type: 'querystring')
      youtube.set_endpoint('http://www.youtube.com/oembed')
      youtube.set_schemes(['http://www.youtube.com/watch?v=*'])
      youtube
    end

    def initialize
      self.providers = []
    end

    def get(url, params = {})
      provider = self.find_provider(url)
      provider.get(ConsumerRequest.new(url, params)) if provider
    end

    def find_provider(target)
      self.providers.each do |pv|
        return pv if pv.match_scheme? target
      end

      false
    end
  end
end
