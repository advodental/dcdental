# frozen_string_literal: true

require 'test_helper'
require 'dcdental/client'

module Dcdental
  class ClientTest < Minitest::Test
    def test_that_auth_defined
      client = Dcdental::Client.new

      assert client.respond_to? :auth
    end

    def test_that_customer_defined
      client = Dcdental::Client.new

      assert client.respond_to? :customer
    end
  end
end
