module Hotel
  class Reservation

    attr_reader :availibility, :check_in, :check_out, :cost, :reservation_id,

    def initalize

      @check_in = # date
      @check_out = # date
      @cost = # $200/night
      @reservation_id = #random generated id
    end

    # methods
    # - Find duration of stay
    # - Find total cost
    # - Generate an reservation ID

  end
end
