require 'pry'
require 'awesome_print'
require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out, :dates_booked

    # dates booked is an array excluding check_out date
    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out

      if @check_in >= @check_out
        raise StandardError, "Your check in and check out date is not valid!"
      end

      @dates_booked = (check_in...check_out).to_a
    end


    def overlaps?(range)
      @dates_booked & range.dates_booked == [] ? false : true
    end


  end
end
