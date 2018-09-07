require_relative 'reservation'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations

    def initialize
      @reservations = []
      @rooms = [*1..20]
    end

    def make_reservation(check_in_date:, check_out_date:)
      # TODO find a room that's available
      room_number = get_available_room(check_in_date: check_in_date, check_out_date: check_out_date)

      reservation = Reservation.new(check_in_date: check_in_date, check_out_date: check_out_date, room_number: room_number)

      @reservations << reservation
      return reservation
    end

    def get_available_room(check_in_date:, check_out_date:)
      return @rooms.first
    end

    def list_all_rooms_in_hotel
      all_rooms = [*1..20]
      return all_rooms
    end

    def calculate_booking_cost(reservation)
      cost = reservation.booking_date_range.length * 200
      return cost
    end

    def list_bookings_by_date(specific_date)
      @booked_dates.select do |date|
        if date[0] == specific_date
          return date
        else
          ################
          #rescue later on
          return nil
        end
      end
    end
  end
end
