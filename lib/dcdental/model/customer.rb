# frozen_string_literal: true

require_relative './base'

module Dcdental
  module Model
    # model to parse customer responses
    class Customer < Base
      # rubocop:disable Metrics/MethodLength
      def self.parse_item(item)
        return unless item

        OpenStruct.new(
          internal_id: item['internalid'],
          entity_id: item['entityid'],
          email: item['email'],
          phone: item['phone'],
          alt_phone: item['altphone'],
          fax: item['fax'],
          contact: item['contact'],
          alt_email: item['altemail']
        )
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
