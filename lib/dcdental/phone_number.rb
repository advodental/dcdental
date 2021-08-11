# frozen_string_literal: true

module Dcdental
  # class to normalize phone number
  class PhoneNumber
    # @param [String] phone_number
    def initialize(phone_number)
      @phone_number = phone_number
    end

    # @return [String] in format XXX-XXX-XXXX
    def to_s
      return '' unless @phone_number

      number = @phone_number.to_s.gsub(/[^\d]/, '')
      if number.length == 10
        "#{number[0..2]}-#{number[3..5]}-#{number[6..9]}"
      else
        number
      end
    end
  end
end
