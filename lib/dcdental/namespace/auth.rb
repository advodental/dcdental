# frozen_string_literal: true

require_relative '../api'

module Dcdental
  module Namespace
    # Auth requests
    class Auth < API
      BASE_PATH = '/app/site/hosting/restlet.nl'

      # request to check authorization
      def get
        params = {
          script: 'customscript_pri_rest_auth',
          deploy: 'customdeploy_pri_rest_auth'
        }
        get_request(BASE_PATH, params)
      end
    end
  end
end
