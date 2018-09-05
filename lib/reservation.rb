# Jacquelyn Cheng - Nodes

# Reservation: Keeps track of a single guest's reservation.

require 'date'

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :nights, :nightly_rate, :room

    def initialize(start_date, end_date, room)
      @checkin_date = Date.parse(start_date)
      @checkout_date = Date.parse(end_date)
      @nights = checkout_date - checkin_date
      @nightly_rate = 200
      @room = room
    end

    def total_cost
      return (nights * nightly_rate).to_f.round(2)
    end
  end
end
