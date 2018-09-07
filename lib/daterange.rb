# Nessary - do not remove
# gems
require "date"
# libfiles

# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date:, end_date:)
      @start_date = Date.parse(start_date.to_s)
      @end_date = Date.parse(end_date.to_s)
    end

    def is_valid?
      raise StandardError, "Invalid DateRange (end must be > start)" unless end_date > start_date
    end

    def duration
      return (end_date - start_date).to_i
    end

    def follows?(oldrange) # caution: easy to switch...
      if self.is_valid?
        return oldrange.end_date <= start_date
      end
    end

  end
end
