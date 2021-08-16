# frozen_string_literal: true

require_relative '../api'
require_relative '../model/order'

module Dcdental
  module Namespace
    # DCDental product endpoints
    class Order < API
      BASE_PATH = '/app/site/hosting/restlet.nl'
      SCRIPT = 'customscript_pri_rest_salesorder'
      DEPLOY = 'customdeploy_pri_rest_salesord_advo4297'

      BASE_PARAMS = { script: SCRIPT, deploy: DEPLOY }.freeze

      ## Get orders
      # @param [Integer] or [String] customer_id
      # @param [String] customer_email
      # @param [String] transaction_id
      # @param [Integer] page_size = 50
      # @param [Integer] page = 1
      # @return [OpenStruct(:internal_id, :order_type, :tran_date, :tran_id, :entity,
      #                     :memo, amount, :tracking_numbers, :status_ref, :ship_date,
      #                     :shipping_cost, :tax_total,
      #                     traking_numbers_links: [:tracking_number, :link])]
      def list(customer_id: nil, email: nil, transaction_id: nil, page_size: 50, page: 1)
        params = { customerid: customer_id, email: email, tranid: transaction_id }.compact
        params = if params.empty?
                   BASE_PARAMS.merge(pagesize: page_size, page: page)
                 else
                   BASE_PARAMS.merge(params)
                 end
        response = get_request(BASE_PATH, params)
        Model::Order.from_response(response['result']) if response['success']
      end

      ## Get order
      # @param [Integer] or [String] order_id
      # @return [OpenStruct(:id, :tran_date, :tran_id, :entity, :other_ref_num,
      #                     :total, :status, :ship_date, :shipping_cost, :tax_total,
      #                     line_items: [OpenStruct(:line, :line_uniq_key, :item, :item_display,
      #                                  :description, :is_closed, :quantity,
      #                                  :quantity_backordered, :quantity_billed,
      #                                  :quantity_committed, :quantity_fullfilled,
      #                                  :rate, :amount, :custcol_item_manufacturer,
      #                                  :custcolcustcol_notes)]
      def by_id(id)
        params = BASE_PARAMS.merge(internalid: id)
        response = get_request(BASE_PATH, params)
        Model::Order.from_response(response['result']) if response['success']
      end

      ## Create order
      # @param [Object] order: {
      #   payload_ID # original system id, for synchronization purposes
      #   entity # required. Dcdental customer id
      #   tran_date # required. Order transaction date format MM/DD/YYYY
      #   other_ref_num # required. Purchase Order number
      #   memo # note of the order
      #   ship_address_list # required. Dcdental Ship address id
      #   bill_address_list # required. Dcdental Bill address id
      #   items [ # required
      #     itemid # required. Dcdental product id
      #     quantity # required
      #     rate     # required. Unit price
      #     custcolcustcol_notes # notes
      #   ]
      # }
      # @return [String] or [Integer] - internal id
      def create(order)
        body = order.to_h.dup
        body = {
          body: body
        }
        response = post_request(BASE_PATH, body, BASE_PARAMS)
        response['result'] if response['success']
      end
    end
  end
end
