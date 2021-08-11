# frozen_string_literal: true

module Dcdental
  module Model
    # Base model to parse responses
    class Base
      def self.from_response(response)
        return unless response

        if response.is_a? Array
          response.map { |item| parse_item(item) }
        else
          parse_item(response)
        end
      end
    end
  end
end
