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

      # @reservations = rooms.map do |room|
      #   room = Hotel::Reservation.new(id: nil, room: room, start_date: nil, end_date: nil, price_per_night: 200)
      # end
      return rooms
    end

    def make_reservation(start_date, end_date)
      assigned_room = assign_available_room(start_date, end_date)
      reservation = Hotel::Reservation.new(id: 1, room: assigned_room, start_date: start_date, end_date: end_date, price_per_night: 200)
      @reservations << reservation
    end

    def assign_available_room(new_d1, new_d2)
      @reservations.each do |reservation|
        old_d1 = reservation.start_date
        old_d2 = reservation.end_date
        if new_d1.between?(old_d1, old_d2) == false && new_d2.between?(old_d1, old_d2) == false && old_d1.between?(new_d1, new_d2) == false && old_d2.between?(new_d1, new_d2) == false
        return reservation.room
        end
      end
    end

    def search_reservations(start_date_2, end_date_2)
      reservations_within_date = []
      @reservations.each do |reservation|
        if
          reservation.start_date < end_date_2 && start_date_2 < reservation.end_date
          reservations_within_date << reservation
        end
      end
      # binding.pry
      return reservations_within_date
    end

    # def total_cost(id)


    # def assign_available_room(start_date_2)
    #   reservations_within_date = []
    #   @reservations.each do |reservation|
    #     if reservation.start_date < end_date_2 && start_date_2 <= reservation.end_date
    #     elsif reservations_within_date << reservation
    #       # binding.pry
    #     end
    #     return reservations_within_date
    #   end
    # end
    #
    #
    #
    def find_reservation(id)
      reservation = @reservations.find { |reservation| reservation.id == id }
      return reservation
    end

    def total_cost(id)
      reservation = find_reservation(id)
      nights = reservation.end_date - reservation.start_date
      total_cost = nights * reservation.price_per_night
      return total_cost
    end
  end
end
