# frozen_string_literal: true

require_relative "api/factory"
require_relative 'request'

module Dcdental
  class API
    include Dcdental::Request

    def self.namespace(name, options = {})
      if public_method_defined?(name)
        raise ArgumentError, "namespace '#{name}' is already defined"
      end

      class_name = extract_class_name(name, options)

      define_method(name) do |*args, &block|
        options = args.last.is_a?(Hash) ? args.pop : {}
        API::Factory.new(class_name, &block)
      end
    end

    def self.extract_class_name(name, options)
      converted  = options.fetch(:full_name, name).to_s
      converted  = converted.split('_').map(&:capitalize).join
      class_name = options.fetch(:root, false) ? '': "#{self.name}::"
      class_name += converted
      class_name
    end
  end
end
