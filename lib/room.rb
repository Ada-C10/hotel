require 'date'

module Hotel

  class Room
    VALID_ROOMS = (1..20).to_a

    attr_reader :room_number, :reservations

    def initialize
      raise StandardError.new('Created too many rooms.') if VALID_ROOMS.empty?

      @room_number = generate_id
      @reservations = []
    end

    def add_reservation(reservation_object)
      raise ArgumentError.new('Please add a valid reservation.') if reservation_object.class != Hotel::Reservation

      @reservations << reservation_object
    end

    #does the date range overlap with a reservation?
    def is_available?(date_range)

      @reservations.each do |reservation|
        #if date_range has nothing in common with reservations range, then set_difference is date_range
        set_difference = date_range - (reservation.checkin_date..reservation.checkout_date).to_a

        #if set difference not equal to date_range, return false
        if !(set_difference == date_range)
          return false
        end

      end

      return true
    end

    private

    def generate_id
      VALID_ROOMS.pop()
    end

  end
end
