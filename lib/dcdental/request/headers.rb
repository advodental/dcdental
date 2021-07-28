# frozen_string_literal: true

require "cgi"
require "openssl"
require "uri"

module Dcdental::Request
  module Headers
    # method: GET or POST
    def headers(method)
      {
        "Content-Type"  => "application/json",
        "Authorization" => build_authorization_header(method)
      }
    end

    private
    def build_authorization_header(method)
      auth_hash = default_authorization_header_values.merge(
        oauth_timestamp: generate_timestamp, 
        oauth_nonce: generate_nonce,
      )
      base_auth_string = headers_to_string(auth_hash)
      auth_hash[:oauth_signature] = generate_signature(method, base_auth_string)
      auth_string = headers_to_string(auth_hash)
      "OAuth #{auth_string}"
    end

    def default_authorization_header_values
      default_authorization_header_values ||= {
        realm: Dcdental.configuration.realm,
        oauth_consumer_key: Dcdental.configuration.consumer_key,
        oauth_token: Dcdental.configuration.token_id,
        oauth_signature_method: "HMAC-SHA256",
        oauth_version: "1.0"
      }
    end

    def headers_to_string(headers)
      headers.collect { |k, v| k.to_s + '="' + url_encode(v) + '"' }.join(",")
    end

    def generate_nonce(size = 32)
      ##Base64.encode64(OpenSSL::Random.random_bytes(size)).gsub(/W/, "")
      #Random.rand(100000).to_s
      "3XmHspcvtZK"
    end

    def generate_timestamp
      #Time.now.getutc.to_i.to_s
      "1627476165"
    end

    def generate_signature(method, auth_params)
      base_string = "#{method}&#{url_encode(Dcdental.configuration.base_url)}&#{url_encode(auth_params)}"
      sign(base_string)
    end

    def sign(base_string)
      digest = OpenSSL::Digest.new('sha256')
      hmac = OpenSSL::HMAC.digest(digest, key, base_string)
      Base64.encode64(hmac).chomp.gsub(/n/, '')
    end

    def key
      Dcdental.configuration.consumer_secret + Dcdental.configuration.token_secret
    end

    def url_encode(url)
      CGI.escape(url)
    end
  end
end
