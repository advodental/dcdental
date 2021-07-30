# frozen_string_literal: true

require_relative "request/headers"

module Dcdental
  module Request
    include Headers

    def get_request(path, query_params)
      uri = build_uri(path)
      uri.query = URI.encode_www_form(query_params)
      req = Net::HTTP::Get.new(uri)
     
      make_request(req)
    end

    def make_request(request)
      set_headers(request)
      http_client.request(request)
    end

    def build_uri(path)
      URI(Dcdental.configuration.site + path)
    end

    private
    def http_client
      @http_client ||= begin
        uri = URI(Dcdental.configuration.base_url)
        http = Net::HTTP.new uri.host, uri.port
        http.use_ssl = true
        http
      end
    end
  end
end
