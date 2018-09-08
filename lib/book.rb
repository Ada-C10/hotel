# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Book class is responsible for:
# holding all reservations,
# searching through them, and
# making new reservations.

  class Book
    require_relative "reservation"

    attr_reader :reservations, :hotel

    def initialize(hotel) # expects a dependency injection (HotBook::Hotel.new)
      @hotel = hotel
      @reservations = []
    end

    def new_reservation(daterange) # expects that arg is a HotBook::DateRange
      raise ArgumentError, "Invalid daterange (expected HotBook::DateRange, " \
                           "not #{daterange.class})" unless
                            daterange.is_a? HotBook::DateRange
      new_reservation = HotBook::Reservation.new(daterange: daterange,
                                                 room_number: default_room,
                                                 room_rate: default_rate)
      @reservations << new_reservation
      return new_reservation
    end

    def default_room
      return hotel.rooms.first[:room_number]
    end

    def default_rate
      return hotel.rooms.first[:room_rate]
    end

    def list_by_date(date) # expects that arg is a Class::Date
      raise ArgumentError, "Invalid date - use Date.parse (expected Date, " \
                           "not #{date.class})" unless date.is_a? Date
      return reservations.select {|reservation| reservation.range.include? date}
    end
  end

end
