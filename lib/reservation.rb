require 'date'
require 'awesome_print'
require_relative 'duration'

=begin
This will keep track of all the reservations

1. create method for available/unavailable rooms based on date range

2.

=end


module Hotel
  class Reservation

    PRICE_PER_NIGHT = 200.00
    attr_reader :id, :duration, :room_number


    def initialize(id, duration, room_number)
      @id = id
      @duration = duration
      @room_number = room_number
    end


    def total_cost
      return (@duration.number_of_nights * PRICE_PER_NIGHT).round(2)
    end

  end

end

# b = Hotel::Duration.new('2018-09-01', '2018-09-05')
# c = b.total_duration
# ap c
# a = Hotel::Reservation.new(1,c)
# puts a.total_cost
