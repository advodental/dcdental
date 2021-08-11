# frozen_string_literal: true

require_relative 'api'

# API client
module Dcdental
  class Client < API
    require_relative 'namespace/auth'
    require_relative 'namespace/customer'
    require_relative 'namespace/customer_address'

    namespace :auth
    namespace :customer
    namespace :customer_address
    # namespace :customer_cc
    # namespace :product
  end
end
