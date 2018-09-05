require 'pry'
class Reservation
  attr_reader :guest_id, :room_id, :date_range, :cost

  @@reservations = []

  def initialize(guest_id, room_id, date_range)
    @guest_id = guest_id
    @room_id = room_id
    @date_range = date_range
    @cost = calculate_cost
    @@reservations << self
  end

  def calculate_cost
    nights = (date_range[0]..date_range[-1]).count - 1
    nights * 200.00
  end

  def self.retrieve_by_date(date)
    raise ArgumentError, "Valid date format was not provided." if date.class != Date
    reservations_for_date = []
    @@reservations.each do |reservation|
      binding.pry
      check_in = reservation.date_range.first
      check_out = reservation.date_range.last
      if (check_in..check_out).include? date
        reservation_for_date << reservation
      end
    end
    reservations_for_date
  end

end
