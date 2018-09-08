# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Reservation class is responsible for calculating reservation cost
  class Reservation
    require_relative "daterange"
    attr_reader :daterange, :duration, :room_number, :room_rate

    def initialize(daterange:, room_number:, room_rate:)
      @daterange = daterange
      @room_number = room_number # what about room.number
      @room_rate = room_rate # and room.rate
      @duration = daterange.duration
    end

    def cost
      return duration * room_rate
    end

    def range
      return daterange.to_range
    end

  end

end
