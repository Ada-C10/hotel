require 'date'

module Hotel

  attr_reader :reservations, :num_rooms

  class RoomBlock < Reservation

    ROOM_BLOCK_DISCOUNT = 0.8

    def initialize(input)

      super(input)
      # validate_date

      @num_rooms = input[:num_rooms]
      @room_number = input[:room_number].nil? ? [] : input[:room_number]
      @reservations = input[:reservations].nil? ? [] : input[:reservations]
    end

    def validate_date
      super
    end

  end
end
