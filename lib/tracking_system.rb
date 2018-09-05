require_relative 'room'
require_relative 'reservation'

NUMBER_OF_ROOMS = 20
STANDARD_ROOM_PRICE = 200.0

class TrackingSystem
  attr_reader :all_rooms, :reservations

  def initialize
    @all_rooms = add_rooms #should i add << avail and unavail?
    @reservations = []
  end

  def add_rooms
    all_rooms = []
    NUMBER_OF_ROOMS.times do |i|
      i += 1
      i = Room.new({room_num: i, price: STANDARD_ROOM_PRICE, availability: :AVAILABLE})
      all_rooms << i
    end
    return all_rooms
  end

  def make_reservation(checkin_time: nil, checkout_time: nil, customer: "")
    reservation = Reservation.new(attributes = {room_num: 0, checkin_time: Date.new, checkout_time: Date.new, price: STANDARD_ROOM_PRICE, customer: ""})
    @reservations << reservation
  end



end



#reservation attributes
# @room_num = input[:room_num]
# @checkin_time = input[:checkin_time]
# @checkout_time = input[:checkout_time]
# @price = input[:price]
# @customer = input[:customer]


# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day, so the
# guest should not be charged for that night
# For this wave, any room can be reserved at any time, and
# you don't need to check whether reservations conflict with each other (this will come in wave 2!)
