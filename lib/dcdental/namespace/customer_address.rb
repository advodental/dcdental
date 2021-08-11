# frozen_string_literal: true

require_relative '../api'
require_relative '../model/customer_address'
require_relative '../phone_number'

module Dcdental
  module Namespace
    # DCDental customer address endpoints
    class CustomerAddress < API
      BASE_PATH = '/app/site/hosting/restlet.nl'
      SCRIPT = 'customscript_pri_rest_customer_address'
      DEPLOY = 'customdeploy_pri_rest_cust_addr_advo4297'

      BASE_PARAMS = { script: SCRIPT, deploy: DEPLOY }.freeze

      def list(customer_id: nil, email: nil, page_size: 5, page: 1)
        raise ArgumentError, 'customer_id or email is required' if customer_id.nil? && email.nil?

        params = { customer_id: customer_id, email: email }.compact
        params = BASE_PARAMS.merge(params).merge(pagesize: page_size, page: page)
        response = get_request(BASE_PATH, params)
        Model::CustomerAddress.from_response(response['result']) if response['success']
      end

      ## Create customer address
      # @param [Integer] or [String] customer_id
      # @param [Object] customer address: {
      #  default_billing   # required true/false
      #  default_shipping  # required true/false
      #  label # Free form text field representing the address record.
      #        # If omitted, the value is set to the same as the addr1 field value.
      #  addressee    # required
      #  attention    # required
      #  city         # required
      #  state        # required
      #  country      # required
      #  zip          # required
      #  addr1        # required
      #  addr2
      #  addr3
      #  addr_phone
      #  custrecord_state_license_number
      #  custrecord_state_license_expiration
      #  custrecord_dea_number
      # @return [Object]
      def create(customer_id:, address:)
        body = address.to_h.dup
        body = {
          parameters: {
            customerid: customer_id
          },
          body: body
        }
        response = post_request(BASE_PATH, body, BASE_PARAMS)
        Model::CustomerAddress.from_response(response['result']) if response['success']
      end

      ## Update customer address
      # @param [Integer] or [String] customer_id
      # @param [Integer] or [String] address_id
      # @param [Object] customer address: {
      #  default_billing   # required true/false
      #  default_shipping  # required true/false
      #  label # Free form text field representing the address record.
      #        # If omitted, the value is set to the same as the addr1 field value.
      #  addressee:   # required
      #  attention:   # required
      #  city         # required
      #  state        # required
      #  country      # required
      #  zip          # required
      #  addr1        # required
      #  addr2
      #  addr3
      #  addr_phone
      #  custrecord_state_license_number
      #  custrecord_state_license_expiration
      #  custrecord_dea_number
      # @return [Object]
      def update(customer_id:, address_id:, address:)
        address_hash = prepare_update_body(address)
        body = {
          parameters: {
            customerid: customer_id,
            addressid: address_id
          },
          body: address_hash
        }
        response = put_request(BASE_PATH, body, BASE_PARAMS)
        Model::CustomerAddress.from_response(response['result']) if response['success']
      end

      private

      def prepare_update_body(address)
        address_hash = address.dup.to_h
        %i[id internal_id].each { |key| address_hash.delete(key) }
        address_hash
      end

      def assign_default_values(customer)
        phone_number = PhoneNumber.new(customer[:phone]).to_s
        customer[:entity_id] = "CUST #{phone_number}" unless customer.key? :entity_id
      end
    end
  end
end
