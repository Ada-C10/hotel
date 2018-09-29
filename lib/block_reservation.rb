require 'reservation'

module Hotel
  class BlockReservation < Reservation
    attr_reader :rooms_available, :reservations

    def initialize(id, room, start_date, end_date, reservations: [])
      super(id, room, start_date, end_date)

      @rooms_available = room.dup
      @reservations = reservations
      @room_cost = 150
    end

    def reservation_cost(reservation)
      # https://stackoverflow.com/questions/4502245/how-can-i-find-the-number-of-days-between-two-date-objects-in-ruby
      total_nights = end_date.mjd - start_date.mjd

      cost = total_nights * room_cost

      return cost
    end
  end
end
