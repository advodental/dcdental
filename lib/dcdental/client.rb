# frozen_string_literal: true
require_relative "api"

module Dcdental
  class Client < API
    require_relative "client/auth"

    namespace :auth
    # namespace :customer
    # namespace :customer_address
    # namespace :customer_cc
    # namespace :product
  end
end
