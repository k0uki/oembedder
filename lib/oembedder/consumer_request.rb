module Oembedder

  class ConsumerRequest
    attr_accessor :url, :maxwidth, :maxheight, :format

    def initialize(url, params = {})
      @url = url
      @maxwidth = params[:maxwidth]
      @maxheight = params[:maxheight]
      @format = params[:format] ||= :json # default is json
    end

    def urlparams
      param = "?url=#{self.url}"
      param += "&maxwidth=#{self.maxwidth}" if self.maxwidth
      param += "&maxheight=#{self.maxheight}" if self.maxheight
      param
    end
  end
end
