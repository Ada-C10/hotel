# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Reservation class is responsible for calculating reservation cost
  class Reservation
    require "csv"
    require_relative "daterange"
    attr_reader :daterange, :room_number, :room_rate, :notes

    # RESERVATION_DATA_FILENAME = "data/reservation_data.csv"

    def initialize(daterange:, room_number:, room_rate:, notes: nil)
      @daterange = daterange
      @room_number = room_number
      @room_rate = room_rate
      @notes = notes
      # @csv_headers = ["start date", "end date", "room number", "room rate", "notes"]
    end

    def duration
      return daterange.duration
    end

    def cost
      return duration * room_rate
    end

    def range
      return daterange.to_range
    end

# Returns an array of hashes of all reservations
    # def self.all(filename)
    #   return data = CSV.open(filename, headers:true).map { |reservation|
    #     p reservation
    #     self.new(daterange: HotBook::DateRange.new(start_date: reservation["start date"],
    #                                                end_date: reservation["end date"]),
    #              room_number: reservation["room number"],
    #              room_rate: reservation["room rate"],
    #              notes: reservation["notes"] )
    #   }
    # end

    # def self.list_by_date(date)
    #   raise ArgumentError, "Invalid date - use Date.parse (expected Date, " \
    #                        "not #{date.class})" unless date.is_a? Date
    #   return self.all.select {|reservation| reservation.range.include? date}
    # end

    # def append(filename)
    #   CSV.open(filename, "a+") { |file|
    #     if file.first == nil
    #       file << @csv_headers
    #     end
    #       file << [self.daterange.start_date, self.daterange.end_date,
    #                self.room_number, self.room_rate, self.notes] }
    # end
  end
end
#
# daterange = HotBook::DateRange.new(start_date: "apr_6", end_date: "apr_8")
# HotBook::Reservation.new(daterange: daterange, room_number: "one",
#                          room_rate: 1.0, filename: RESERVATION_DATA_FILENAME)
