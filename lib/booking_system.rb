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

    def list_all_rooms
      return @rooms
    end

    def list_existing_reservations(date)
      bookings_by_date = []

      specific_date = Date.parse("#{date}")
      @reservations.each do |booking|
        booking.date_range.each do |date|
          if specific_date == date
            bookings_by_date << booking
          end
        end
      end

      return bookings_by_date
    end
  end
end
