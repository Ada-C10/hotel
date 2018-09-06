require 'date'


module Hotel

  class Room
    VALID_ROOMS = (1..20).to_a

    attr_reader :room_number, :reservations

    def initialize

      #to constant or not to constant, that is one of my questions
      @room_number = generate_id
      @reservations = []
    end

    #does the date range overlap with reservation?
    def is_available?(date_range)

      @reservations.each do |reservation|

        set_difference = date_range - (reservation.checkin_date..reservation.checkout_date).to_a
        #if equal, no elements shared with date_range, return true, else false
        return set_difference == date_range
      end
    end

    def add_reservation(reservation_object)
      raise ArgumentError.new('Please add a valid reservation') if reservation_object.class != Hotel::Reservation

      @reservations << reservation_object
    end

    private

    def generate_id
      VALID_ROOMS.pop()
    end

  end
end
