# frozen_string_literal: true

# Extensions for Hash class
class Hash
  # Underscore and symbolize keys
  #
  unless method_defined? :normalize_keys
    def normalize_keys
      each_with_object({}) do |(key, value), normalized|
        normalized[key.to_s.underscore_with_space.to_sym] = case value
                                                 when Hash
                                                   value.normalize_keys
                                                 when Array
                                                   value.map { |item| item.is_a?(Hash) ? item.normalize_keys : item }
                                                 else
                                                   value
                                                 end
      end
    end
  end

  # Returns a new hash with keys removed
  #
  unless method_defined? :except
    def except(*items)
      dup.except!(*items)
    end
  end

  # Similar to except but modifies self
  #
  unless method_defined? :except!
    def except!(*keys)
      keys.each { |key| delete(key) }
      self
    end
  end
end
