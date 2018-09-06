require 'date'

class Reservation

  attr_reader :checkin_date, :checkout_date, :price, :room_number, :reservation_id, :customer

  def initialize(checkin_date, checkout_date, room, customer, price_per_night = 200)
    check_date_range(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date = checkout_date
    @customer = customer
    @room = room
    @room_number = room.room_number
    @reservation_id = create_unique_id(room_number, checkin_date)
    @price_per_night = price_per_night
    @price = calculate_price(checkin_date, checkout_date, price_per_night).to_i
  end

  def check_date_range(start, finish)
    raise StandardError, 'Invalid date range' unless start < finish
  end

  def create_unique_id(room_number, checkin_date)
    "#{room_number}000#{checkin_date.ld}".to_i
  end

  def calculate_price(checkin_date, checkout_date, price_per_night)
    (checkout_date - checkin_date) * price_per_night
  end

end

class BlockReservation < Reservation
  attr_reader :block_code, :room_list, :checkin_date, :checkout_date, :price, :discounted_rate
  def initialize(checkin_date, checkout_date, room_list, discounted_rate, block_code)
    raise ArgumentError, 'Maximum block size is 5 rooms' if room_list.length > 5
    check_date_range(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date = checkout_date
    @discounted_rate = discounted_rate
    @price = calculate_price(checkin_date, checkout_date, discounted_rate)
    @room_list = room_list
    @block_code = block_code
  end
end
