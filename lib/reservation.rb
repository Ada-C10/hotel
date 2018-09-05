# Jacquelyn Cheng - Nodes

# Reservation: Keeps track of a single reservation's info.

require 'date'

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :nights, :nightly_rate, :room, :confirmation_number

    def initialize(checkin_date, checkout_date, room, confirmation_number)
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @nights = checkout_date - checkin_date
      @nightly_rate = 200
      @room = room
      @confirmation_number = confirmation_number
    end

    def total_cost
      return (nights * nightly_rate).to_f.round(2)
    end
  end
end
