# frozen_string_literal: true

require 'json'
require_relative 'request/headers'

module Dcdental
  # general module to make requests
  module Request
    include Headers

    def get_request(path, query_params)
      uri = build_uri(path)
      uri.query = URI.encode_www_form(query_params)
      req = Net::HTTP::Get.new(uri)

      make_request(req)
    end

    def make_request(request)
      apply_headers(request)
      response = http_client.request(request)
      process_response(response)
    end

    def process_response(response)
      case response
      when Net::HTTPSuccess
        JSON.parse response.body
      when Net::HTTPUnauthorized
        { 'error' => "#{response.message}: username and password set and correct?" }
      when Net::HTTPServerError
        { 'error' => "#{response.message}: try again later?" }
      else
        { 'error' => response.message }
      end
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
