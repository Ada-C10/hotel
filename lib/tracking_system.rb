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
      i = Room.new({room_num: i, price: STANDARD_ROOM_PRICE, reserved_dates: []})
      all_rooms << i
    end
    return all_rooms
  end

  #access the list of all of the rooms in the hotel
  def view_all_rooms
    return @all_rooms
  end

  # reserve a room for a given date range
  def make_reservation(checkin_time: checkin, checkout_time: checkout)
    # 1. pick a room that is available. the next available room?
    @all_rooms.each do |room|
      room.reserved_dates.each do |reserved_date| # this is a hash containing {checkin_time: checkin, checkout_time: checkout}
        if !(reserved_date[checkin_time:]..reserved_date[checkout_time:]).include?(checkin_time: checkin)

          #you can use a range to see if a date is included in that range (Date..Datenow)
    # go in @all_rooms and find the first room_num whos checkOUT_time is earlier than input's checkin_time(this is gonna work because i'll store peoples checout time internally as ending a day before)
    # raise argument error if inside @all_rooms no room is available on this date range (then admin would need to input a new date range)
    # else..make the new reservation below
    reservation = Reservation.new(date_range: {checkin_time: checkin, checkout_time: checkout -1}, room: room)  # <----room object contains {room_num:, price: STANDARD_ROOM_PRICE, customer: ""}
    @reservations << reservation
    room.reserved_dates << {checkin_time: checkin, checkout_time: checkout}
  end

  #access the list of reservations for a specific date
  #get the total cost for a given reservation

  private #helper methods below
  def view_two_dates_as_range()
  def check_if_rooms_available_on(date_range)

  #############################  #############################   #############################
end
#think about how each room can be reserved thru time


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
