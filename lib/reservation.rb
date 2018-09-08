require 'pry'
require 'awesome_print'
require 'date'

module Hotel
  class Reservation
    attr_reader :id, :date_range, :room
    attr_accessor :cost

    def initialize(id, date_range)
      @id = id
      @date_range = date_range
      @cost = calculate_total_cost
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
      total_days = @date_range.dates_booked.length
      total_cost = 200 * total_days
    end


    # def add_reservation(reserv)
    #   # add the reservation to the array @reservations
    # end


  end
end
