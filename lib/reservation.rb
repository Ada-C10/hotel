require 'time'

module Hotel
  class Reservation
    attr_accessor :id, :room, :start_date, :end_date, :cost

    def initialize(id, room, start_date, end_date, cost=200)
      @id = id
      @room = room # object; not num
      @start_date = start_date
      @end_date = end_date
      @cost = cost
    end

    def dates_reserved()
      # don't include the end end_date since that is the checkout date
      return (@start_date...@end_date).to_a
    end

  end
end
