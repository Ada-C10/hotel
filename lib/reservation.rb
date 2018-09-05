require 'date'

module Hotel
  class Reservation

    attr_reader :check_in, :check_out, :cost, :reservation_id

    def initialize(check_in, check_out, cost, reservation_id)


      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @cost = cost
      @reservation_id = reservation_id

      unless @check_out > @check_in
        raise StandardError.new("Check-out can not be before check-in. Chech-out is: #{@check_out} check-in is #{@check_in}")
      end
    end

    # methods
    # - Find duration of stay
    # - Find total cost
    # - Generate an reservation ID

  end
end
