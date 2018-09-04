require 'date'

class Reservation

  attr_reader :checkin_date, :checkout_date, :price, :room_number, :reservation_id

  def initialize(checkin_date, checkout_date, room_number)
    check_date_range(checkin_date, checkout_date)
    @checkin_date = checkin_date
    @checkout_date = checkout_date
    @last_night = checkout_date - 1
    @room = find_room(room_number)
  end

  def check_date_range(start, finish)
    raise StandardError, 'Invalid date range' unless start < finish
  end




  def find_room(room_number)

  end





end
