# frozen_string_literal: true
require_relative '../api'

module Dcdental
  class Client::Auth < API

    def authorize
      params = {
        script: "customscript_pri_rest_auth",
        deploy: "customdeploy_pri_rest_auth"
      }
      get_request(params)
    end
  end
end
