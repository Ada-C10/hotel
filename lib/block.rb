require_relative 'reservation'

module Hotel
  class Block < Reservation

    attr_reader :number_of_rooms, :cost, :rooms

    def initialize(check_in, check_out, number_of_rooms)
      super(check_in, check_out)

      @number_of_rooms = number_of_rooms
      if number_of_rooms < 2 || number_of_rooms > 5
        raise ArgumentError, "Number of rooms must be between 2 and 5"
      end

      size_discounts = {
        2 => 0.05 * PRICE,
        3 => 0.1 * PRICE,
        4 => 0.15 * PRICE,
        5 => 0.2 * PRICE
      }

      @cost -= size_discounts[number_of_rooms]

      @rooms = {}
    end

    def set_available_status(room)
      rooms[room] = :available
    end

    def set_unavailable_status(room)
      rooms[room] = :unavailable
    end

  end
end
