require_relative 'room'
require_relative 'reservation'

class TrackingSystem
  attr_reader :available_rooms, :unavailable_rooms, :all_rooms

  def initialize
    @available_rooms = []
    @unavailable_rooms = []
    @all_rooms = [] #Admin can access the list of all of the rooms in the hotel, should i << avail and unavail?
  end
  # 
  # def make_reservation(checkin_time: nil, checkout_time: nil)
  #   Reservation.new({room_num: assign_available_room, checkin_time:)
  # end

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
