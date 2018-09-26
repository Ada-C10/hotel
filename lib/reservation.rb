# Jacquelyn Cheng - Nodes

# Reservation: Keeps track of a single reservation's info.

module Hotel
  class Reservation < BookingDates
    attr_reader :checkin, :checkout, :room, :rate, :block

    @@all_reservations = []

    def initialize(checkin, checkout, room, discount_rate: nil, block_name: nil)
      super(checkin, checkout)
      @room = room
      @rate = discount_rate ||= room.rate
      @block_name = block_name
      @reservation_num = @@all_reservations.length
      @@all_reservations << self
    end

    def self.all
      return @@all_reservations
    end

    def self.find(reservation_num)
      return all.select { |reservation| reservation.reservation_num == reservation_num }
    end

    def total_cost
      return nights * rate
    end
  end
end
