require 'date'
require_relative 'reservation'

module Hotel
  class Room
    attr_reader :num, :reservations

    def initialize(input)
      @num = input[:num]
      @reservations = input[:reservations].nil? ? [] : input[:reservations]

      unless (1..20).include? @num
        raise ArgumentError, "This is not a valid room number."
      end

    end

    def add_reservation(reservation)
      @reservations << reservation
    end

  end
end
