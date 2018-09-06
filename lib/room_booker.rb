require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class RoomBooker
    attr_reader :rooms, :reservations

    # TODO: Change class name to booking system?

    def initialize
      # All my rooms
      @rooms = (1..20).to_a
      # List of reservations. Organized by room?
      @reservations = []
    end

    def list_rooms
      return @rooms
    end

    def make_reservation(start_date, end_date)
      check_valid_dates

        #think...what if there's no available rooms, raise an exception

      date_range = Hotel::DateRange.new(start_date, end_date)
      reservation = Reservation.new(date_range, find_available_room)

      @reservations << reservation
    end

    # If we need reservations for a particular room:
    # @reservations.select { |res| res.room_number == room_number }

    def list_reservations_by_date(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
    end



    def find_available_room
      # begin

        if dates_overlap?(dates_array)
          raise ArgumentError
        else
          @reservations
        end

      # rescue
    end


  end
end

# a = Hotel::RoomBooker.new()
# puts a.list_rooms
