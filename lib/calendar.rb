require 'date'

module Hotel
  class Calendar
    attr_reader :check_in, :check_out

    def initialize(check_in:, check_out:)

# QUESTION: separate error handling into its own method? YES
# ^^ also if check_out is nil --> just look at one date
      unless /\d{4}-\d{1,2}-\d{1,2}/.match(check_in) && /\d{4}-\d{1,2}-\d{1,2}/.match(check_out)
        raise StandardError, "Improper date format: date must be entered as YYYY-MM-DD."
      end

      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      unless @check_in < @check_out
        raise StandardError, "Invalid date range: end date must occur after start date."
      end
    end

# TODO: create date range and check without arrays?
    # def create_date_range()
    #   # QUESTION: shoudl i just use instance var instead of input local var?
    #   return (@check_in...@check_out).to_a
    # end

    def overlap?(other_dates) # param: Calendar obj
      if !(other_dates.check_in <= @check_out-1) || !(other_dates.check_out-1 >= @check_in)
        return false
      else
        return true
      end
    end




  end
end

#
# cal = Hotel::Calendar.new(check_in: "1986-07-29", check_out: "1986-07-31")
#
# puts cal.check_in
