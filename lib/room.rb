require 'date'

module Hotel
  class Room
    attr_accessor :num, :reservations

    def initialize(input)
      @num = input[:num]
      @reservations = []
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

  end
end
