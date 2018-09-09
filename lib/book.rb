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
    require "date"
    attr_reader :reservations, :hotel

    def initialize(hotel) # expects a dependency injection (HotBook::Hotel.new)
      @hotel = hotel
      @reservations = load_reservations(TEST_FILENAME)
    end

    def new_reservation(daterange, room_number: suggested_room(daterange)) # expects that arg is a HotBook::DateRange
      raise_data_type_error(:daterange, daterange)
      raise_data_type_error(:room_number, room_number)
      room_is_bookable?(room_number, daterange) # raises error if not
      new_reservation = HotBook::Reservation.new(daterange: daterange,
                                                 room_number: room_number,
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

    def suggested_room(daterange)
      available_room_numbers = list_available_room_numbers(daterange)
      return available_room_numbers.first
    end

    def default_rate
      return hotel.rooms.first[:room_rate]
    end

    def list_reservations(date) # expects that arg is a Class::Date
      raise_data_type_error(:date, date)
      return reservations.select {|reservation| reservation.range.include? date}
    end

    def room_is_bookable?(room_number, daterange)
      raise_data_type_error(:room_number, room_number)
      raise_data_type_error(:daterange, daterange)
      query = room_number.upcase
      available_room_numbers = list_available_room_numbers(daterange)
      raise StandardError, "No room by that number" unless
                            available_room_numbers.include?(query)
      return true
    end

    def list_available_room_numbers(daterange) # expects that arg is a HotBook::DateRange
      raise_data_type_error(:daterange, daterange)
      conflicting_reservations = reservations.select { |reservation|
                                 reservation.daterange.conflict?(daterange) }
      unavailable_room_numbers = conflicting_reservations.map { |reservation|
                                 reservation.room_number }
      available_room_numbers = hotel.room_numbers - unavailable_room_numbers
      return available_room_numbers
    end

    private

    def raise_data_type_error(type, var)
      case type
      when :date
        raise ArgumentError, "Invalid date - use Date.parse (expected Date, " \
                             "not #{var.class})" unless var.is_a? Date
      when :room_number
        raise ArgumentError, "Invalid room number (expected String, " \
                             "not #{var.class})" unless var.is_a? String
      when :daterange
        raise ArgumentError, "Invalid daterange (expected HotBook::DateRange, " \
                             "not #{var.class})" unless
                              var.is_a? HotBook::DateRange
     end
   end

  end
end
