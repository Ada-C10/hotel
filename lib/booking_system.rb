require_relative 'date_range'
require_relative 'reservation'

module Hotel
  class BookingSystem
    attr_reader :reservations, :rooms

    VALID_ROOM_NUMBERS = (1..20)
    ROOM_COST = 200

    def initialize
      @reservations = []
      @rooms = VALID_ROOM_NUMBERS
    end


    ####
    # room: an Integer for the room number
    # check_in: a Date object for the check in day
    # check_out: a Date object for the check out day
    def book_room(room_number, check_in, check_out)
      unless VALID_ROOM_NUMBERS.include?(room_number)
        raise ArgumentError
      end

      date_range = Hotel::DateRange.new(check_in, check_out)
      new_reservation = Hotel::Reservation.new(room_number, ROOM_COST, date_range)

      @reservations << new_reservation

      return new_reservation
    end


    def list_available_rooms
      available_room = []
      reservation_list.include?(available_room)

      return available_room

      # to find available room: check if dates overlap - two dates to compare
      # output boolean
      #
      # reservation_attempt, has start and end date, comparing existing reservations start and end date
    end

    def reservations_on_date(date)
      reservations = []
      @reservations.each do |reservation|
        if reservation.within_reservation?(date)
          reservations << reservation
        end
      end
      return reservations
    end
    

  end
end
