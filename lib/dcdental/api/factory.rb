# frozen_string_literal: true

module Dcdental
  class API
    # factory to create instance of API namespaces
    class Factory
      def self.new(klass)
        raise ArgumentError, 'must provide API class to be instantiated' unless klass

        create_instance(klass)
      end

      def self.create_instance(klass)
        convert_to_constant(klass.to_s).new
      end

      def self.convert_to_constant(classes)
        classes.split('::').inject(Dcdental) do |constant, klass|
          constant.const_get klass
        end
      end
    end
  end
end
