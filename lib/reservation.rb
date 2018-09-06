require 'pry'
require 'time'
require 'date'



class Reservation
  attr_reader :id, :room, :date_range, :total_cost

  RATE_PER_NIGHT = 200

  # put it in an input data structure similar to trips

  def initialize(id:, room:, date_range:, total_cost:)

    @id = id
    @room = room
    # @start_date = start_date
    # @end_date = end_date
    @date_range = DateRange.new(start_date, end_date)
    @total_cost = total_cost


  end


  def cost_calculator
    duration = @date_range.duration_cal

    total_cost = (duration) * RATE_PER_NIGHT

    return total_cost.round(2)
  end

end
