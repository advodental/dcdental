# frozen_string_literal: true

require_relative '../api'

module Dcdental
  class Client::Customer < API
    BASE_PATH = "/app/site/hosting/restlet.nl"

    def get(id)
      params = {
        script: "customscript_pri_rest_customer",
        deploy: "customdeploy_pri_rest_customer_advo4297",
        "internalId": id
      }
      get_request(BASE_PATH, params)
    end
  end
end
