# frozen_string_literal: true

require_relative '../api'
require_relative '../model/customer'
require_relative '../phone_number'

module Dcdental
  module Namespace
    # DCDental customer endpoints
    class Customer < API
      BASE_PATH = '/app/site/hosting/restlet.nl'
      SCRIPT = 'customscript_pri_rest_customer'
      DEPLOY = 'customdeploy_pri_rest_customer_advo4297'

      BASE_PARAMS = { script: SCRIPT, deploy: DEPLOY }.freeze

      def list(page_size: 5, page: 1)
        params = BASE_PARAMS.merge(pagesize: page_size, page: page)
        response = get_request(BASE_PATH, params)
        Model::Customer.from_response(response['result']) if response['success']
      end

      ## Get customer by id
      # @param [Integer] or [String] internal_id - id on DCDental
      # @return OpenStruct(:internal_id, :entity_id, :phone, :email, :alt_phone, :alt_email, :fax, :contact)
      def by_id(internal_id)
        params = BASE_PARAMS.merge(internalid: internal_id)

        response = get_request(BASE_PATH, params)
        Model::Customer.from_response((response['result'] || []).first) if response['success']
      end

      ## Create customer
      # @param [Object] customer: {
      #   entitystatus # Possible values are 16 (customer lost), 13 (customer won) and 19 (customer at-risk)
      #   entityid # The Customer Name, typically a Phone Number in the following format: XXX-XXX-XXXX
      #   externalid # Reference number from the source system
      #   companyname
      #   phone
      #   email
      #   alt_phone
      #   alt_email
      #   fax
      #   contact
      # }
      # @return [String] or [Integer] - internal id
      def create(customer)
        body = customer.to_h.dup
        assign_default_values(body)
        body = {
          body: body
        }
        response = post_request(BASE_PATH, body, BASE_PARAMS)
        response['result'] if response['success']
      end

      ## Update customer
      # @param [Integer] or [String] internal_id # id on DCDental
      # @param [Object] customer: {
      #   entity_status # Possible values are 16 (customer lost), 13 (customer won) and 19 (customer at-risk)
      #   entity_id # The Customer Name, typically a Phone Number in the following format: XXX-XXX-XXXX
      #   external_id # Reference number from the source system
      #   company_name
      #   phone
      #   email
      #   alt_phone
      #   alt_email
      #   fax
      #   contact
      # }
      # @return [String] or [Integer] - internal id
      def update(internal_id, customer)
        customer_hash = customer.dup.to_h
        %i[id internal_id].each { |key| customer_hash.delete(key) }
        body = {
          parameters: {
            customerid: internal_id
          },
          body: customer_hash
        }
        response = put_request(BASE_PATH, body, BASE_PARAMS)
        response['result'] if response['success']
      end

      private

      def assign_default_values(customer)
        phone_number = PhoneNumber.new(customer[:phone]).to_s
        customer[:entity_id] = "CUST #{phone_number}" unless customer.key? :entity_id
      end
    end
  end
end
