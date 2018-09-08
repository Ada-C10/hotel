require_relative 'reservation'

REG_RATE = 200

module Hotel
  class Room
    attr_reader :room_num, :rate

    def initialize(input)
      @room_num = input[:room_num]
      @rate = input[:rate].nil? ? REG_RATE : input[:rate]
    end
  end
end
