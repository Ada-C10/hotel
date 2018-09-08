require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class BookingSystem
    attr_reader :room, :reservations

    # TODO: Change class name to booking system?

    def initialize
      # All my rooms
      @room = (1..20).to_a
      # List of reservations. Organized by room?
      @reservations = []
    end

    def list_rooms
      return @room
    end

    def make_reservation(date_range)
      #think...what if there's no available rooms, raise an exception
      room = find_available_room(date_range)
      reservation = Reservation.new(date_range, room)
      @reservations << reservation
    end

    # If we need reservations for a particular room:
    # @reservations.select { |res| res.room_number == room_number }

    def reservations_by_date(date_range)
      return @reservations.select { |res| res.date_range == date_range }
    end

    def find_available_room(date_range)

      # TODO: refactor?

      return 1 if @reservations.empty?

      unavailable_rooms = []
      available_rooms = []

      @reservations.each do |res|
        if date_range.dates_overlap?(res.date_range)
          unavailable_rooms << res.room_number
        end
      end

      @room.each do |r|
        unavailable_rooms.each do |unavailable_room|
          if r != unavailable_room
            available_rooms << r
          end
        end
      end

      return available_rooms.first
    end







  end
end

# a = Hotel::RoomBooker.new()
# puts a.list_rooms
