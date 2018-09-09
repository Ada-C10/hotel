require_relative 'reservation'

REG_RATE = 200

module Hotel
  class Room
    class InvalidRateError < StandardError; end

    attr_reader :room_num, :rate

    def initialize(input)
      check_rate_validity?(input[:rate])
      @room_num = input[:room_num]
      @rate = input[:rate].nil? ? REG_RATE : input[:rate]
    end

    def check_rate_validity?(rate)
      valid_types = /^(10|\d)(\.\d{1,2})?$/
      if valid_types.match(rate.to_s) && !(rate.is_a?(Float) || rate.is_a?(Integer))
        raise InvalidRateError.new("That is not a valid Rate amount")
      end
    end
  end
end
