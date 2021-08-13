# frozen_string_literal: true

require_relative '../api'
require_relative '../model/product'

module Dcdental
  module Namespace
    # DCDental product endpoints
    class Product < API
      BASE_PATH = '/app/site/hosting/restlet.nl'
      SCRIPT = 'customscript_pri_rest_product'
      DEPLOY = 'customdeploy_pri_rest_product_advo4297'

      BASE_PARAMS = { script: SCRIPT, deploy: DEPLOY }.freeze

      ## Get products by ids or by pagination
      # @param [Integer] or [String] or [Array] item_id
      # @param [Integer] page_size = 50
      # @param [Integer] page = 1
      # @return [OpenStruct(:manufacturer, :dcd_id, :dcd_item, :description,:active_promotion,
      #                     :availability, product_unitprice, :schein_code, :abc, :dea_required,
      #                     :item_image_thumb, :item_image_full, :category_lvl_i, :category_lvl_ii,
      #                     :category_lvl_iii)]
      def list(item_id: nil, page_size: 50, page: 1)
        params = if item_id
                   ids = item_id.is_a?(Array) ? item_id.join(',') : item_id
                   BASE_PARAMS.merge(itemid: ids)
                 else
                   BASE_PARAMS.merge(pagesize: page_size, page: page)
                 end
        response = get_request(BASE_PATH, params)
        Model::Product.from_response(response['result']) if response['success']
      end
    end
  end
end
