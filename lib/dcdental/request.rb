# frozen_string_literal: true

require 'json'
require_relative 'request/headers'

module Dcdental
  # general module to make requests
  module Request
    include Headers

    def get_request(path, query_params)
      uri = build_uri(path, query_params)
      req = Net::HTTP::Get.new(uri)

      make_request(req)
    end

    def post_request(path, body, query_params = nil)
      uri = build_uri(path, query_params)
      req = Net::HTTP::Post.new(uri)
      req.body = normalize_keys(body).to_json if body

      make_request(req)
    end

    def put_request(path, body, query_params = nil)
      uri = build_uri(path, query_params)
      req = Net::HTTP::Put.new(uri)
      req.body = normalize_keys(body).to_json if body

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
        parse_success_response(response)
      when Net::HTTPUnauthorized
        raise ApiError, "#{response.message}: username and password set and correct?"
      when Net::HTTPServerError
        raise ApiError, "#{response.message}: try again later?"
      else
        raise ApiError, "#{response.message}. Body: #{response.body}"
      end
    end

    def parse_success_response(response)
      body = JSON.parse response.body
      raise ApiError, body['exception'] unless body['success']

      body
    end

    def build_uri(path, query_params = nil)
      uri = URI(Dcdental.configuration.site + path)
      uri.query = URI.encode_www_form(normalize_keys(query_params)) if query_params
      uri
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

    def normalize_keys(hash)
      return {} unless hash

      hash.each_with_object({}) do |(key, value), obj|
        normalized_key = key.to_s.gsub('_', '').downcase
        obj[normalized_key] = if value.is_a?(Hash)
                                normalize_keys(value)
                              else
                                value
                              end
      end
    end
  end
end
