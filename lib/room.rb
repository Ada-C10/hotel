require_relative 'reservation'

STATUS_OPTIONS = [:AVAILABLE, :UNAVAILABLE]

module Hotel
  class Room
    attr_reader :room_number, :booked_reservations

    def initialize(input)
      @room_number = input[:room_number]
      @booked_reservations = input[:booked_reservations].nil? ? [] : input[:booked_reservations]

      raise ArgumentError.new("That is an invalid Room Number") unless @room_number.between?(1, 20)
    end

    def add_booked_reservation(reservation)
      raise ArgumentError unless reservation.is_a? Reservation
      @booked_reservations << reservation
    end
  end
end
