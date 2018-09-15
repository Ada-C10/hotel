require 'date'
require 'pry'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room_id, :reservation_dates, :total_cost

    def initialize(reservation_dates, room_id)

      @reservation_dates = reservation_dates
      @room_id = room_id
      @total_cost = reservation_cost(reservation_dates)

    end

    def reservation_cost(reservation_dates)
      nightly_cost = 200
      total_days = (reservation_dates.length).to_i
      total_cost = total_days * nightly_cost
    end

  end
end



# def validate_dates
#   raise ArgumentError.new("The end date must be after the start date") if @end_date <= @start_date
#
#   raise ArgumentError.new("The start date can't be nil") if @start_date == nil
#
#   raise ArgumentError.new("The end date can't be nil") if @end_date == nil
# end
