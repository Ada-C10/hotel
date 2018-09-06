COST_OF_ROOM = 200

module Hotel
  class Reservation

    def initialize(number, check_in, check_out)
      @id = number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @nights = check_out - check_in
      @rooms = []#instance of a room
      @total_cost = 0
    end



      def assign_room_to_reservation
      end

      def calculate_reservation_cost(rooms)
        total_cost = rooms.length * nights * COST_OF_ROOM
        return total_cost
      end
    end
  end
