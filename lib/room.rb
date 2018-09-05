# Jacquelyn Cheng - Nodes

# Room: Keeps track of the availability of hotel rooms.
require 'date'

module Hotel
  class Room
    attr_reader :rooms_in_hotel, :room_num, :availability
    @@rooms_in_hotel = 0
    AVAILABLE_STARTING = Date.parse("2019-01-01")
    AVAILABLE_THRU = Date.parse("2019-12-31")

    def initialize(room_num)
      @room_num = room_num
      @availability = {}
      AVAILABLE_STARTING.upto(AVAILABLE_THRU) { |date|
        @availability[date.to_s] = :AVAILABLE
      }
      @@rooms_in_hotel += 1
    end

    def is_available?(checkin_date, final_night_date = nil)
      if final_night_date == nil
        final_night_date = checkin_date
      end
      checkin_date.upto(final_night_date) { |date|
        return false if @availability[date.to_s] == :UNAVAILABLE
      }
      return true
    end

    # updates availability for dates of reservation
    def reserve(checkin_date, final_night_date)
      # room is unavailable from checkin to night before checkout
      # room is available day of checkout for reservations starting that evening
      checkin_date.upto(final_night_date) { |date|
        @availability[date.to_s] = :UNAVAILABLE
      }
      return self
    end


  end
end
