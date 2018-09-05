require 'date'

module Hotel
  class Reservation
    attr_accessor :id, :room, :start_date, :end_date, :cost

    def initialize(input)
      @id = input[:id]
      @room = input[:room] # object; not num TODO
      @start_date = Date.parse(input[:start_date])
      @end_date = Date.parse(input[:end_date])
      @daily_rate = input[:daily_rate]
    end

    def dates_reserved()
      # don't include the end end_date since that is the checkout date
      return (@start_date...@end_date).to_a
    end

  end
end
