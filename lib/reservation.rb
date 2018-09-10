require 'pry'
require 'awesome_print'
require 'date'
require_relative 'room'

module Hotel
  class Reservation
    attr_reader :id, :date_range
    attr_accessor :room

    def initialize(id, date_range)
      @id = id
      @date_range = date_range
      # placeholder room initation
      @room = Hotel::Room.new(0)
    end

    def cost
      @cost = calculate_total_cost
    end
    
    def calculate_total_cost
      total_days = @date_range.dates_booked.length
      total_cost = @room.cost * total_days
      return total_cost
    end


  end
end
