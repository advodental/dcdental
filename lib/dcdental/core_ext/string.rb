# frozen_string_literal: true

# Extensions for String class
class String
  # Return underscored string
  #
  unless method_defined? :underscore
    def underscore
      gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .tr(' ', '_')
        .downcase
    end
  end

  # Similar to underscore but modifies self
  #
  unless method_defined? :underscore!
    def underscore!
      replace(underscore)
    end
  end
end
