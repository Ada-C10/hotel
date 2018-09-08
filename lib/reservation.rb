# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Reservation class is responsible for calculating reservation cost
  class Reservation
    require "csv"
    require_relative "daterange"
    RESERVATION_DATA_FILENAME = "data/reservation_data.csv"
    attr_reader :daterange, :duration, :room_number, :room_rate

    def initialize(daterange:, room_number:, room_rate:,
                   filename: RESERVATION_DATA_FILENAME)
      @daterange = daterange
      @room_number = room_number # what about room.number
      @room_rate = room_rate # and room.rate
      @duration = daterange.duration
      save_reservation(filename)
    end

    def cost
      return duration * room_rate
    end

    def range
      return daterange.to_range
    end

    private

# when you initialize a reservation, it writes information about itself into the next line in the CSV
# later, add a reservation ID
    def save_reservation(filename)
      headers = ["start date", "end date", "room number", "room rate"]
      CSV.open(filename, "a+") { |file|
        if file.first == nil
          file << headers
        end
          file << [self.daterange.start_date, self.daterange.end_date,
                   self.room_number, self.room_rate] }
    end
  end
end
