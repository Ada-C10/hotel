module Hotel
  class Reservation
    attr_reader :room, :number_nights
    attr_accessor :guest_name, :start_date, :end_date, :cost_per_night

    def initialize(room, guest_name:, start_date:, end_date:, cost_per_night: 200.00)
      @room = room.number
      @guest_name = guest_name
      check_dates(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @cost_per_night = cost_per_night
      @number_nights = (@end_date - @start_date).to_i
    end # of initialize method

    def check_dates(start_date, end_date)
      if start_date > end_date
        raise ArgumentError.new "Invalid date range. Start date must be before end date, both in format of 'Month dd, yyyy'. "
      end
    end

  end# of class Reservation
end #of Hotel module
