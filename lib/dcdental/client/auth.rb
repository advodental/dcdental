# frozen_string_literal: true
require_relative '../api'

module Dcdental
  class Client::Auth < API
    BASE_PATH = "/app/site/hosting/restlet.nl"

    def get
      params = {
        script: "customscript_pri_rest_auth",
        deploy: "customdeploy_pri_rest_auth"
      }
      get_request(BASE_PATH, params)
    end
  end
end
