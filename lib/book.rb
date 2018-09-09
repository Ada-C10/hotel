# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Book class is responsible for:
# holding all reservations,
# searching through them, and
# making new reservations.

TEST_FILENAME = "support/test_reservation_data.csv"

  class Book
    require_relative "reservation"

    attr_reader :reservations, :hotel

    def initialize(hotel) # expects a dependency injection (HotBook::Hotel.new)
      @hotel = hotel
      @reservations = load_reservations(TEST_FILENAME)
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

    def load_reservations(filename)
      reservations = CSV.open(filename, headers: true).map { |row|
        start_date = row["start date"]
        end_date = row["end date"]
        room_number = row["room number"]
        room_rate = row["room rate"].to_f
        notes = row["notes"]
        HotBook::Reservation.new(
          daterange: HotBook::DateRange.new(start_date: start_date,
                                            end_date: end_date),
          room_number: room_number, room_rate: room_rate, notes: notes)
      }
      return reservations
    end

    def save_reservations(filename)
    end

    def default_room
      return hotel.rooms.first[:room_number]
    end

    def default_rate
      return hotel.rooms.first[:room_rate]
    end

    def list_reservations(date) # expects that arg is a Class::Date
      raise ArgumentError, "Invalid date - use Date.parse (expected Date, " \
                           "not #{date.class})" unless date.is_a? Date
      return reservations.select {|reservation| reservation.range.include? date}
    end

    def list_available_rooms(daterange) # expects that arg is a HotBook::DateRange
      conflicting_reservations = reservations.select { |reservation|
         reservation.daterange.conflict?(daterange) }
      unavailable_room_numbers = conflicting_reservations.map { |reservation|
        reservation.room_number }
      return hotel.room_numbers - unavailable_room_numbers
    end
  end

end
