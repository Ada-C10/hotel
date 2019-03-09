require 'date'
require 'pry'

require_relative 'Booking'

class Reservation
  # Refactor Note: This would have been a lot easier if I had made thsi
    # A hash. Having room_number required became difficult later when
    # I attempted to assign a reservation based on a date range alone
    # Reservation will need to know whether or not a date range is placed
      # aside for a block room

  attr_reader :room_number, :check_in, :check_out, :cost_per_night, :total

  # def initialize(room_number, check_in, check_out, cost_per_night=200)
    def initialize(args)
      args = defaults.merge(args)
      @room_number = args[:room_number]
      @check_in = args[:check_in]
      @check_out = args[:check_out]
      validate_reservation_dates(@check_in, @check_out)
      @cost_per_night = args[:cost_per_night]
      @total = reservation_cost
  end

  def defaults
    {
      check_in: Date.today,
      check_out: Date.today + 2,
      cost_per_night: 200
    }
  end

  def validate_reservation_dates(check_in, check_out)
    if @check_in.class != Date || @check_out.class != Date
      raise ArgumentError, "Please enter a date in mm-dd-yyyy format"
    end

    if @check_out < @check_in
      raise ArgumentError, "Check out date must be after check in date."
    end
  end

  # Attempted to transfer a DateRange method but was unsucessful. Would like
  # to try again in a refactor
  def number_of_days_reserved
    # binding.pry
    return (check_out - check_in).to_i
  end

  def reservation_cost
    return number_of_days_reserved * cost_per_night
  end
end
