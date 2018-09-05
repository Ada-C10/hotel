require 'date'

class Reservation

  attr_reader :checkin_date, :checkout_date, :price, :room_number, :reservation_id

  def initialize(checkin_date, checkout_date, room, price_per_night = 200)
    check_date_range(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date = checkout_date
    @room = room
    @room_number = room.room_number
    @reservation_id = create_unique_id(room_number, checkin_date)
    @price_per_night = price_per_night
    @price = calculate_price(checkin_date, checkout_date, price_per_night)
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
  def initialize(checkin_date, checkout_date, room_list, discounted_rate, block_code)
    room_list.each do |room|
      super(checkin_date, checkout_date, room, discounted_rate)
    end
    @block_code = block_code
  end
end
