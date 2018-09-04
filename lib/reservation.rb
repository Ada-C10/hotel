require 'date'

module Hotel
  class Reservation

    attr_reader :checkin_date, :checkout_date, :total_cost, :confirmation_id

    ROOM_COST = 200

    def initialize(checkin_date, checkout_date)

      #how to check invalid dates?

      @confirmation_id = #generate random id here
      @checkin_date = Date.parse(checkin_date)
      @checkout_date = Date.parse(checkout_date)

      if @checkout_date <= @checkin_date
        raise StandardError.new('Checkout can\'t be the same as or before checkin.')
      end

      @total_cost = calculate_total_cost
    end

    def calculate_total_cost
      return ROOM_COST * (@checkout_date.mjd - @checkin_date.mjd)
      #modified julian number
    end
  end
end
