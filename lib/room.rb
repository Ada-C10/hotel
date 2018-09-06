# Jacquelyn Cheng - Nodes

# Room: Keeps track of the availability of hotel rooms.

module Hotel
  class Room
    attr_reader :room_num, :availability

    NIGHTLY_RATE = 200.00
    VALID_STATUSES = [:AVAILABLE, :BOOKED, :BLOCKED]

    def initialize(room_num, available_starting, available_thru)
      @room_num =       room_num
      @availability =   {}
      # add room status and rate by day to availability hash
      add_inventory(available_starting, available_thru)
    end

    # makes new dates available for the room
    # raises ArgumentError if invalid dates provided, returns true if successful
    def add_inventory(available_starting, available_thru)
      if available_thru < available_starting
        raise ArgumentError, "Start date must be before end date."
      elsif availability[available_starting.to_s]
        raise ArgumentError, "New dates of availbility overlap with existing inventory."
      else # add new dates of availability to room
        available_starting.upto(available_thru) do |date|
          availability[date.to_s] = { :status => :AVAILABLE, :rate => NIGHTLY_RATE }
        end
        return true
      end
    end

    # checks availability for a specific night or date range
    # returns true if available for entire date range, false otherwise
    def is_available?(checkin_date, checkout_date = nil)
      if checkout_date == nil
        checkout_date = checkin_date.next_day
      end
      unless availability[checkin_date.to_s] && availability[checkout_date.prev_day.to_s]
        return false
      end
      checkin_date.upto(checkout_date.prev_day) do |date|
        return false if availability[date.to_s][:status] != :AVAILABLE
      end
      return true
    end

    # updates availability for date to :BOOKED or :BLOCKED
    # raises an ArgumentError if invalid status, returns new status if successful
    def change_room_status(date, room_status)
      unless VALID_STATUSES.include? room_status
        raise ArgumentError, "Invalid status: #{room_status}"
      end
      # room is unavailable from checkin to night before checkout
      # room is available day of checkout for reservations starting that evening
      availability[date.to_s][:status] = room_status
      return availability[date.to_s][:status]
    end

    # gets the nightly rate for a specific night as a float with 2 decimals
    def nightly_rate(date)
      return availability[date.to_s][:rate].to_f.round(2)
    end

    # update the nightly rate for a specific night or date range
    # raises an ArgumentError if invalid rate, returns new rate if successful
    def change_nightly_rate(date, new_rate)
      if new_rate < 0 || !(new_rate.is_a? Numeric)
        raise ArgumentError, "Invalid rate: #{new_rate}"
      end
      availability[date.to_s][:rate] = new_rate
      return availability[date.to_s][:rate]
    end
  end
end
