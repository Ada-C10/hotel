require 'date'

module Hotel

  class Room

    attr_reader :room_number, :reservations

    def initialize(input)

      @room_number = input
      @reservations = []
    end

    def add_reservation(reservation_object)

      @reservations << reservation_object
    end

    #does the date range overlap with a reservation?
    def is_available?(date_range)

      @reservations.each do |reservation|

        # #if date_range has nothing in common with reservations range, then set_difference is date_range
        range_set_difference = date_range - ((reservation.checkin_date..reservation.checkout_date).to_a - [reservation.checkout_date])

        # #if set difference not equal to date_range, return false
        if !(range_set_difference == date_range)
          return false
        end
      end

      return true
    end

  end

end
