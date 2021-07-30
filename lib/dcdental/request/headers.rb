# frozen_string_literal: true

require "oauth"

module Dcdental::Request
  module Headers

    def set_headers(request)
      request["Content-Type"] = "application/json"
      set_oauth_header(request)
    end

    private
    def set_oauth_header(request)
      oauth_params = { consumer: oauth_consumer, token: oauth_token, request_uri: request.uri, realm: realm }
      helper = OAuth::Client::Helper.new(request, oauth_params.merge(signature_method: "HMAC-SHA256"))
      request["Authorization"] = helper.header
    end

    def oauth_consumer
      OAuth::Consumer.new(consumer_key, consumer_secret, site: site)
    end
    
    def realm
      Dcdental.configuration.realm
    end

    def site
      Dcdental.configuration.site
    end

    def oauth_token
       OAuth::AccessToken.new(oauth_consumer, token, token_secret) 
    end

    def token
      Dcdental.configuration.token_id
    end

    def token_secret
      Dcdental.configuration.token_secret
    end

    def consumer_secret
      Dcdental.configuration.consumer_secret
    end

    def consumer_key
      Dcdental.configuration.consumer_key
    end
  end
end
