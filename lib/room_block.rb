require 'date'

module Hotel

  attr_reader :reservations, :num_rooms

  class RoomBlock < Reservation

    ROOM_BLOCK_DISCOUNT = 0.8

    def initialize(input)

      super(input)
      validate_date

      @num_rooms = input[:num_rooms]
      raise ArgumentError.new("Room blocks of more than 5 and less than 2 are not allowed.") if @num_rooms > 5 || @num_rooms < 2

      @reservations = input[:reservations].nil? ? [] : input[:reservations]
    end

    def validate_date
      super
    end

  end
end
