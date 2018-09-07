require 'pry'
require 'awesome_print'
require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
    end


    def overlaps?(range)
      # does my range overlap with a different range?
    end

    def includes?(range)
      # does my range include a different range?
    end


  end
end
