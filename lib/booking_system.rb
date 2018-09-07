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
      reservation = Hotel::Reservation.new(id: 1, room: assign_available_room(start_date, end_date), start_date: start_date, end_date: end_date, price_per_night: 200)
      @reservations << reservation
      # binding.pry
    end

    def assign_available_room(start_date_2, end_date_2)
      booked_rooms = []
      available_rooms = []
      @reservations.each do |reservation|
        if
          reservation.start_date < end_date_2 && start_date_2 < reservation.end_date
          booked_rooms << reservation.room
        end
      end
      all_rooms = load_rooms
      available_rooms = all_rooms - booked_rooms
      return available_rooms[0]
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
