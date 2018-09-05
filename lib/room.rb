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

    def is_available?(start_date, end_date = nil)
      checkin = Date.parse(start_date)
      if end_date == nil
        checkout = checkin.next_day
      else
        checkout = Date.parse(end_date)
      end
      checkin.upto(checkout.prev_day) { |date|
        return false if @availability[date.to_s] == :UNAVAILABLE
      }
      return true
    end

    # updates availability for dates of reservation
    def reserve(start_date, end_date)
      checkin = Date.parse(start_date)
      if end_date == nil
        checkout = checkin.next_day
      else
        checkout = Date.parse(end_date)
      end
      # room is unavailable from checkin to night before checkout
      # room is available day of checkout for reservations starting that evening
      checkin.upto(checkout.prev_day) { |date|
        @availability[date.to_s] = :UNAVAILABLE
      }
    end


  end
end
