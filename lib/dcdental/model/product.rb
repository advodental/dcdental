# frozen_string_literal: true

require_relative './base'

module Dcdental
  module Model
    # model to parse product responses
    class Product < Base
      def self.parse_item(item)
        return unless item

        OpenStruct.new(item.normalize_keys)
      end
    end
  end
end
