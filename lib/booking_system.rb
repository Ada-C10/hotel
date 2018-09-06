require_relative 'reservation_creator'

module Hotel
  class BookingSystem
    attr_reader :reservation_date

    def initialize(reservation_date)
      @reservation_date = Date.parse("#{reservation_date}")
    end
    #
    # def available_rooms?
    #   return available_rooms
    #
    # end
    #
    # def load_pending_reservation(check_in_date, check_out_date)
    #   pending = Reservation.new(check_in_date, check_out_date)
    #   # need to figure out date range before doing this
    #   # need to check if date is already there
    #
    #   unless booked_dates.empty?(pending.check_in_date)
    #     booked_dates << pending
    #   end
    # end
    #
    # def assign_room
    # end
    #
    # def rooms_in_hotel
    # end
  end
end


# , :booked_rooms, :booked_dates, :available_rooms, :available_dates
# , booked_rooms, booked_dates, available_rooms, available_dates
# @booked_rooms = []
# @booked_dates = []
# @available_rooms = [*1..20]
# @available_dates = []
