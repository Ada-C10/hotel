require 'pry'
require 'awesome_print'
require 'date'

module Hotel
  class Reservation
    attr_reader :id, :date_range
    attr_accessor :cost, :room
    COST = 200

    def initialize(id, date_range)
      @id = id
      @date_range = date_range
      @cost = calculate_total_cost
    end

    def calculate_total_cost
      total_days = @date_range.dates_booked.length
      total_cost = COST * total_days
      return total_cost
    end

  end
end
