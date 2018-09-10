require 'date'
require 'pry'

require_relative 'room_booking'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room_id

    def initialize(start_date, end_date, room_id)

      @start_date = start_date
      @end_date = end_date
      @room_id = room_id
      @total_cost = reservation_cost(@start_date, @end_date)

      validate_dates

    end


    def validate_dates
      raise ArgumentError.new("The end date must be after the start date") if @end_date <= @start_date

      raise ArgumentError.new("The start date can't be nil") if @start_date == nil

      raise ArgumentError.new("The end date can't be nil") if @end_date == nil
    end


    def reservation_cost(start_date, end_date)
      nightly_cost = 200
      total_days = (end_date - start_date).to_i
      total_cost = total_days * nightly_cost
    end

  end
end
