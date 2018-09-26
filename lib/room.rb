# Jacquelyn Cheng - Nodes

# Room: Keeps track of the availability of hotel rooms.

module Hotel
  class Room
    attr_reader :room_num
    attr_accessor :rate

    ROOM_COUNT = 20
    NIGHTLY_RATE = 200.00

    def initialize(room_num)
      @room_num = room_num
      @bookings = []
      @rate = NIGHTLY_RATE
    end

    def room_factory
      rooms = []
      ROOM_COUNT.times do |room_num|
        rooms << Room.new(room_num + 1)
      end
      return rooms
    end

    def is_available?(checkin, checkout)
      date_range = BookingDates.new(checkin, checkout)
      bookings.each do |booking|
        return false if booking.overlaps?(date_range)
      end
      return true
    end

    def add_booking(booking)
      return bookings << booking
    end

    def remove_booking(booking)
      return booking.delete(booking)
    end
  end
end
