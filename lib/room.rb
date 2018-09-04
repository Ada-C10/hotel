require_relative 'reservation'

STATUS_OPTIONS = [:AVAILABLE, :UNAVAILABLE]

module Hotel
  class Room
    attr_reader :room_number, :booked_reservations, :status

    def initialize(input)
      super(input)
      @room_number = input[:room_number]
      @booked_reservations = input[:booked_reservations].nil? ? [] : input[:booked_reservations]
      @status = input[:status].nil? ? :AVAILABLE : input[:status]

      raise ArgumentError.new("That is an invalid status") unless STATUS_OPTIONS.include?(@status)
      raise ArgumentError.new("That is an invalid Room Number") unless @room_number > 0 && < 21
    end

    def add_booked_reservation(reservation)
      raise ArgumentError unless reservation.is_a? Reservation
      @booked_reservations << reservation
    end

    def becomes_unavailable
      @status = :UNAVAILABLE
    end
  end
end
