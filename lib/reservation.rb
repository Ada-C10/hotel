require 'date'
require 'pry'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date


    def initialize(start_year, start_month, start_day, end_year, end_month, end_day)

      @start_date = generate_date(start_year, start_month, start_day)
      @end_date = generate_date(end_year, end_month, end_day)

      validate_dates

    end


    #make sure there are valid start/end dates
    def validate_dates
      raise ArgumentError.new("The end date must be after the start date") if @end_date <= @start_date

      raise ArgumentError.new("The start date can't be nil") if @start_date == nil

      raise ArgumentError.new("The end date can't be nil") if @end_date == nil
    end



    def generate_date(year, month, day)
      return Date.new(year, month, day)
    end


  end
end


#tests: make sure params for start/end date are in the right format (else argument error)
