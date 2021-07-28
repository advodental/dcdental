# frozen_string_literal: true

module Dcdental
  class Configuration
    attr_accessor :consumer_key, :consumer_secret, :token_id, :token_secret

    def initialize
      @consumer_key = nil
      @consumer_secret = nil
      @token_id = nil
      @token_secret = nil
    end
  end
end
