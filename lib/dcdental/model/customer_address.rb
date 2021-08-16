# frozen_string_literal: true

require_relative './base'

module Dcdental
  module Model
    # model to parse customer responses
    class CustomerAddress < Base
      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def self.parse_item(item)
        return unless item

        OpenStruct.new(
          internal_id: fetch_value(item, 'addressinternalid', 'address_internalid', 'internalid', 'addressid'),
          entity_id: fetch_value(item, 'address_entityid', 'addressentityid', 'entityid'),
          is_residential: item['isresidential'],
          id: item['id'],
          default_billing: item['defaultbilling'],
          default_shipping: item['defaultshipping'],
          label: fetch_value(item, 'address_addresslabel', 'label'),
          attention: fetch_value(item, 'address_attention', 'attention'),
          addressee: fetch_value(item, 'address_addressee', 'addressee'),
          address1: fetch_value(item, 'address_address1', 'addr1'),
          address2: fetch_value(item, 'address_address2', 'addr2'),
          address3: fetch_value(item, 'address_address3', 'addr3'),
          city: fetch_value(item, 'address_city', 'city'),
          state: fetch_value(item, 'address_state', 'state'),
          zipcode: fetch_value(item, 'address_zipcode', 'zip'),
          country: fetch_value(item, 'address_country', 'country') || 'US',
          address_phone: fetch_value(item, 'address_addressphone', 'addrphone'),
          customer_dea_number: fetch_value(item, 'address_custrecord_dea_number', 'custrecord_dea_number'),
          customer_state_license_number: fetch_value(item, 'address_custrecord_state_license_number',
                                                     'custrecord_state_license_number'),
          customer_state_license_expiration: fetch_value(item, 'address_custrecord_state_license_expiration',
                                                         'custrecord_state_license_expiration')
        )
      end
      # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
    end
  end
end
