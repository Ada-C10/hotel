require 'date'
# require 'pry'

module Hotel

  class Room

    #put valid rooms in rservation matchr
    #single room can ask if room numbr is valid
    #somewhere else in the code would have to know if there's a valid room in this Hotel Module

    attr_reader :room_number, :reservations

    def initialize(input)

      @room_number = input
      @reservations = []
    end

    def add_reservation(reservation_object)

      raise ArgumentError.new('Please add a valid reservation.') if reservation_object.class != Hotel::Reservation
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

        # range_and_value = ((reservation.checkin_date..reservation.checkout_date).to_a - [reservation.checkout_date]) && date_range
        # if range_and_value != date_range
        #   return false
        # end

      end

      return true
    end
    
  end
end
