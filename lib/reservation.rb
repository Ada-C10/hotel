require 'date'
require 'pry'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date

    def initialize(start_year, start_month, start_day, end_year, end_month, end_day)

      @start_date = generate_date(start_year, start_month, start_day)

      @end_date = generate_date(end_year, end_month, end_day)

      @total_cost = reservation_cost(@start_date, @end_date)

      validate_dates

    end


    #make sure there are valid start/end dates
    def validate_dates
      raise ArgumentError.new("The end date must be after the start date") if @end_date <= @start_date

      raise ArgumentError.new("The start date can't be nil") if @start_date == nil

      raise ArgumentError.new("The end date can't be nil") if @end_date == nil
    end



    # def generate_date(year, month, day)
    #   return Date.new(year, month, day)
    # end


    def reservation_cost(start_date, end_date)
      nightly_cost = 200
      total_days = (end_date - start_date).to_i
      total_cost = total_days * nightly_cost
    end


  end
end
