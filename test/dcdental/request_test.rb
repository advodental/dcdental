# frozen_string_literal: true

require 'test_helper'
require 'dcdental/request'

module Dcdental
  class RequestTest < Minitest::Test
    include Dcdental::Request

    def setup
      Dcdental.configure do |config|
        config.consumer_key = 'consumer_key'
        config.consumer_secret = 'consumer_secret'
        config.token_id = 'token_id'
        config.token_secret = 'token_secret'
        config.realm = '1111111'
        config.base_url = 'https://advodental.com'
      end
    end

    def test_that_build_auth_header
      headers = headers('GET')
      puts headers
      refute_nil headers
    end
  end
end
