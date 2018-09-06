# Jacquelyn Cheng - Nodes

# Reservation: Keeps track of a single reservation's info.

require 'date'

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :nights, :nightly_rate, :rooms, :confirmation_number

    RATE = 200

    def initialize(checkin_date, checkout_date, nightly_rate = RATE, rooms, confirmation_number)
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @nights = checkout_date - checkin_date
      @nightly_rate = nightly_rate
      @rooms = rooms
      @confirmation_number = confirmation_number
    end

    def total_cost
      return (nights * nightly_rate).to_f.round(2)
    end
  end
end
