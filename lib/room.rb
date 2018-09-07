require 'pry'
require 'awesome_print'
require 'date'

module Hotel
  class Room
    attr_reader :id
    attr_accessor :cost

    def initialize(id)
      @id = id
      @cost = 200
      # @reservations = []
    end


    def is_booked?(date)
      # iterates through reservations, returns true if reservation date includes date argument
      # return true
    end

    def add_reservation(reserv)
      # add the reservation to the array @reservations
    end


  end
end
