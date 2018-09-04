require 'date'

class Reservation

  attr_reader :checkin_date, :checkout_date, :price, :room_number, :reservation_id

  def initialize(checkin_date, checkout_date, room)
    check_date_range(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date = checkout_date
    @room = room
    @room_number = room.room_number
    @reservation_id = create_unique_id(room_number, checkin_date)
    @price = calculate_price(checkin_date, checkout_date, room)
  end

  def check_date_range(start, finish)
    raise StandardError, 'Invalid date range' unless start < finish
  end

  def create_unique_id(room_number, checkin_date)
    "#{room_number}000#{checkin_date.ld}".to_i
  end

  def calculate_price(checkin_date, checkout_date, room)
    (checkout_date - checkin_date) * room.price_per_night
  end

end
