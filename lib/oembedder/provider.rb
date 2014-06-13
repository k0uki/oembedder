module Oembedder
  class Provider
    attr_reader :endpoint, :schemes, :format_type

    def initialize(params = {})
      params[:format_type] ||= "url" # url or querystring
      @format_type = params[:format_type]
    end

    def set_endpoint(endpoint)
      @endpoint = URI.parse(endpoint)
    end

    def set_schemes(schemes)
      @schemes = schemes
    end

    def match_scheme?(target)
      target.gsub!(/\/$/, '') # delete trailing slash
      mc = self.schemes.count do |scheme|
        pattern = Regexp.escape(scheme).gsub('\\*', '[^/]+')
        match = target.match Regexp.new(pattern)

        target.size == match.to_s.size unless match.nil?
      end
      true if mc >= 1
    end

    # get content
    def get(request)
      conn = Faraday.new(:url => "#{self.endpoint.scheme}://#{self.endpoint.host}") do |faraday|
        faraday.request :url_encoded
        # faraday.response :logger
        faraday.response :json, :content_type => /\bjson$/
        faraday.response :xml,  :content_type => /\bxml$/
        faraday.adapter  Faraday.default_adapter
      end

      params = request.urlparams
      params += "&format=#{request.format}" if self.format_type == "querystring"

      response = conn.get(create_request_path(request) + params)

      ProviderResponse.create(request.format, response)
    end

    private
    def create_request_path(request)
      if self.format_type == "url"
        if endpoint.path.match /\.\w+$/
          self.endpoint.path.gsub(/\.\w+$/, ".#{request.format}")
        else
          self.endpoint.path + ".#{request.format}"
        end
      else
        self.endpoint.path
      end
    end
  end
end
