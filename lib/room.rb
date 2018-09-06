# Jacquelyn Cheng - Nodes

# Room: Keeps track of the availability of hotel rooms.
require 'date'

module Hotel
  class Room
    attr_reader :room_num, :availability
    AVAILABLE_STARTING = Date.parse("2019-01-01")
    AVAILABLE_THRU = Date.parse("2019-12-31")

    def initialize(room_num)
      @room_num = room_num
      @availability = {}
      AVAILABLE_STARTING.upto(AVAILABLE_THRU) { |date|
        @availability[date.to_s] = :AVAILABLE
      }
    end

    def is_available?(checkin_date, final_night_date = nil)
      if final_night_date == nil
        final_night_date = checkin_date
      end
      checkin_date.upto(final_night_date) { |date|
        return false unless @availability[date.to_s] == :AVAILABLE
      }
      return true
    end

    # updates availability for dates of reservation to :BOOKED or :BLOCKED
    def change_room_status(checkin_date, final_night_date, room_status)
      # room is unavailable from checkin to night before checkout
      # room is available day of checkout for reservations starting that evening
      checkin_date.upto(final_night_date) { |date|
        @availability[date.to_s] = room_status
      }
      return self
    end
  end
end
