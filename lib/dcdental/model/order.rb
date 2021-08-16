# frozen_string_literal: true

require_relative './base'

module Dcdental
  module Model
    # model to parse order responses
    class Order < Base
      def self.parse_item(item)
        return unless item

        if item['fields'] || item['lines']
          full_order(item)
        else
          general_order(item)
        end
      end

      def self.full_order(item)
        order = base_order_info(item['fields'])
        order.other_ref_num = item['fields']['otherrefnum']
        order.total = item['fields']['total']
        order.status = item['fields']['status']
        order.line_items = line_items(item['lines'])
        order
      end

      def self.line_items(lines)
        return [] unless lines

        lines.map do |line|
          line_item(line)
        end
      end

      # rubocop:disable Metrics/MethodLength
      def self.line_item(line)
        OpenStruct.new(
          line: line['line'],
          line_uniq_key: line['lineuniquekey'],
          item: line['item'],
          item_dispay: line['item_display'],
          description: line['description'],
          is_closed: line['isclosed'],
          quantity: line['quantity'],
          quantity_backordered: line['quantitybackordered'],
          quantity_billed: line['quantitybilled'],
          quantity_committed: line['quantitycommitted'],
          quantity_fullfilled: line['quantityfulfilled'],
          rate: line['rate'],
          amount: line['amount'],
          custcol_item_manufacturer: line['custcol_item_manufacturer'],
          custcolcustcol_notes: line['custcolcustcol_notes']
        )
      end
      # rubocop:enable Metrics/MethodLength

      def self.general_order(item)
        order = base_order_info(item)
        order.order_type = item['ordertype']
        order.amount = item['amount']
        order.status_ref = item['statusref']
        order.memo = item['memo']
        order.tracking_numbers = item['trackingnumbers']
        order.tracking_numbers_links = tracking_numbers_links(item['trackingNumbersLinks'])
        order
      end

      def self.tracking_numbers_links(links)
        return [] unless links

        links.map { |link| OpenStruct.new(tracking_number: link['trackingNumber'], link: link['link']) }
      end

      def self.base_order_info(item)
        OpenStruct.new(
          id: fetch_value(item, 'id', 'internalid'),
          tran_date: item['trandate'],
          tran_id: item['tranid'],
          entity: item['entity'],
          ship_date: item['shipdate'],
          shipping_cost: item['shippingcost'],
          tax_total: item['taxtotal']
        )
      end
    end
  end
end
