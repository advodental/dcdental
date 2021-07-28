# frozen_string_literal: true

require "httparty"
require_relative "request/headers"

module Dcdental
  module Request
    include Headers

    def get_request(params)
      #headers = 
      HTTParty.get(Dcdental.configuration.base_url, query: params, headers: headers("GET"), debug_output: $stdout)
    end
  end
end
