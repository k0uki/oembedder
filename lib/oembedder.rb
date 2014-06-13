require 'faraday'
require 'faraday_middleware'
require 'multi_xml'

require "oembedder/version"
require "oembedder/base"
require "oembedder/consumer_request"
require "oembedder/provider"
require "oembedder/provider_response"

module Oembedder
  class << self
    def new
      Oembedder::Base.setup
    end

    def blank
      Oembedder::Base.new
    end
  end
end
