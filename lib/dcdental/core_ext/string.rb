# frozen_string_literal: true

# Extensions for String class
class String
  # Return underscored string
  #
  unless method_defined? :underscore_with_space
    def underscore_with_space
      gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .downcase
    end
  end

  # Similar to underscore but modifies self
  #
  unless method_defined? :underscore_with_space!
    def underscore_with_space!
      replace(underscore_with_space)
    end
  end
end
