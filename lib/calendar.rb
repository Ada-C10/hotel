require 'date'

module Hotel
  class Calendar
    attr_reader :start_date, :end_date

    def initialize(start_date:, end_date:)

# QUESTION: separate error handling into its own method?
      unless /\d{4}-\d{1,2}-\d{1,2}/.match(start_date) && /\d{4}-\d{1,2}-\d{1,2}/.match(end_date)
        raise StandardError, "Improper date format: date must be entered as YYYY-MM-DD."
      end

      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)

      unless @start_date < @end_date
        raise StandardError, "Invalid date range: end date must occur after start date."
      end
    end

# TODO: create date range and check without arrays?
    def create_date_range()
      # QUESTION: shoudl i just use instance var instead of input local var?
      return (@start_date...@end_date).to_a
    end




  end
end

#
# cal = Hotel::Calendar.new(start_date: "1986-07-29", end_date: "1986-07-31")
#
# puts cal
