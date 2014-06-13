module Oembedder
  class ProviderResponse
    # attr_reader :type, :version, :title, :author_name, :author_url, :provider_name, :provider_url, :cache_age, :thumbnail_url, :thumbnail_width, :thumbnail_height, :url, :html, :width, :height
    attr_reader :raw_data, :status, :has_error, :format

    def self.create(format, faraday_response)
      pr = ProviderResponse.new(format: format)
      pr.handle_status faraday_response
      pr.parse faraday_response.body
      pr
    end

    def initialize(params = {})
      @has_error = false
      @format = params[:format]
    end

    def handle_status(faraday_response)
      @status = faraday_response.status
      @has_error = true unless faraday_response.status == 200
    end

    def parse(response)
      @raw_data = response
    end

    def method_missing(name)
      if data = find_data(name)
        data
      else
        super
      end
    end

    private
    def find_data(name)
      case self.format
      when :json
        @raw_data[name.to_s] if @raw_data.has_key?(name.to_s)
      when :xml
        @raw_data['oembed'][name.to_s] if @raw_data['oembed'].has_key?(name.to_s)
      else
        false
      end
    end

  end
end
