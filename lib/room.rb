require 'date'

module Hotel
  class Room
    attr_accessor :num, :reservations

    def initialize(input)
      @num = input[:num]
      @reservations = input[:reservations].nil? ? [] : input[:reservations]

      # QUESTION: move up??
      unless (1..20).include? @num
        raise ArgumentError, "This is not a valid room number."
      end

    end

    def add_reservation(reservation)
      @reservations << reservation
    end

  end
end
