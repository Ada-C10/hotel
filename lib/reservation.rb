require 'pry'
require 'awesome_print'

require 'date'
require 'time_difference'

module Hotel
  class Reservation
    attr_reader :id, :check_in, :check_out, :room
    attr_accessor :cost

    def initialize(id, check_in, check_out)
      @id = id
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @cost = calculate_total_cost

      #calculate cost

      # how many days?

      # add to booked dates ??
    end


    def is_booked?(date)
      # iterates through reservations, returns true if reservation date includes date argument
      # return true
    end

    def assign_room(rooms)
      @room = rooms[0]
      return rooms[0]
    end

    def calculate_total_cost
      total_days = TimeDifference.between(@check_in, @check_out).in_days.to_int
      total_cost = 200 * total_days
    end


    def add_reservation(reserv)

      # add the reservation to the array @reservations
    end


  end
end
