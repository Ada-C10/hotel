require_relative 'reservation'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations

    def initialize
      @reservations = []
      @rooms = [*1..20]
    end

    def make_reservation(check_in_date:, check_out_date:)

      room_number = get_available_room(check_in_date: check_in_date, check_out_date: check_out_date)
      reservation = Reservation.new(check_in_date: check_in_date, check_out_date: check_out_date, room_number: room_number)

      if @reservations.length >= 1
        reservation.date_range.each do |date|
          if list_reservations_by_date(date).length >= 1
            reservation.room_number = show_available_rooms(date).first
            raise ArgumentError, "unable to reserve/rooms all booked" unless reservation.room_number != nil

            @reservations << reservation
            return reservation
          end
        end
      end

      @reservations << reservation
      return reservation
    end

    def get_available_room(check_in_date:, check_out_date:)
      return @rooms.first
    end

    def list_all_rooms
      return @rooms
    end

    def list_reservations_by_date(date)
      specific_date = Date.parse("#{date}")

      bookings_by_date = []
      @reservations.each do |booking|
        dates = booking.date_range
        bookings_by_date << booking if dates.include?(specific_date)
      end

      return bookings_by_date
    end

    def show_available_rooms(date)
      show = list_reservations_by_date(date).map {|reservation| reservation.room_number }
      return list_all_rooms - show
    end
  end
end
