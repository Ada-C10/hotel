module Hotel
  class BookingSystem
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = load_rooms
      @reservations = []
    end

    def load_rooms
      rooms = []
      i = 1
      20.times do
        rooms << i
        i += 1
      end
      return rooms
    end

    def make_reservation(start_date, end_date)
      assigned_room = 1
      reservation = Hotel::Reservation.new(id: 1, room: assigned_room, start_date: start_date, end_date: end_date, price_per_night: 200)
      @reservations << reservation
    end

    def assign_available_room(new_d1, new_d2)
      @reservations.each do |reservation|
        old_d1 = @reservation.start_date
        old_d2 = @reservation.end_date
        unless new_d1.between?(old_d1, old_d2) && new_d2.between?(old_d1, old_d2)
        return @reservation.room
        end
      end
    end

    #
    # def find_reservation(id)
    #   return @reservations.find { |reservation| reservation.id == id }
    # end
    #
    # def total_cost(id)
    #   find_reservation(id)
    #   nights = @reservation.end_date - @reservation.start_date
    #   total_cost = nights * @reservation.price_per_night
    #   return total_cost
    # end
  end
end
