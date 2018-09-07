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
      i = Room.new({room_num: i, reserved_dates: []})
      all_rooms << i
    end
    return all_rooms
  end

  #access the list of all of the rooms in the hotel
  def view_all_rooms
    return @all_rooms
  end

  # reserve an available room for a given date range
  # ******************************************************************************************
  def make_reservation(start_time, end_time, num)
    @all_rooms.each do |room|
      if room.reserved_dates.empty?
         reservation = Reservation.new({rooms: [room.room_num], start_time: start_time, end_time: end_time, price: 200.0})
         @reservations << reservation
        room.reserved_dates << {start_time: start_time, end_time: end_time}
      else
        room.reserved_dates.each do |reserved_dates|
          if !(reserved_dates[:start_time]..reserved_dates[:end_time]).include?(start_time) #&& room.block == :NA
            reservation = Reservation.new({rooms: [room], start_time: start_time, end_time: end_time, price: 200.0})
            @reservations << reservation
            room.reserved_dates << {start_time: start_time, end_time: end_time}
          else raise ArgumentError.new"There is no room available on that date, out of all 20 rooms"
          end
        end
      end
      return reservation
    end
  end
# *********************************************************************************************************
  #block method idea
  #this method below is going to return a value that can into the Block.rooms << (aka list of rooms in a block), but how/when do i assign these available rooms a block id? Ah i think that i will
  # i will create another method called create_block, call view_available_rooms_on(start_time, end_time) within that
  # and then in that create_block method, update a block status for each room (aka block :A) corresponding to the Block's ID (id: A,B,C etc..)
  #
  # view a list of rooms that are not reserved(aka available) for a given date range

  # def view_available_rooms_on(start_time, end_time)
  #   #available_rooms = []
  #   # @all_rooms.each do |room|
  #   # room.reserved_dates.each do |date_range| <---date_range could be a hash like {checkin_time: checkin, checkout_time: checkout}
  #   ###  if the date_range doesn't include date aka:
  #   # if !date_range.include?(date)
  #   # available_rooms << room
  #   # end
  #   # return available_rooms (this is an array of rooms avail on 'date' passed as param)
  #

  # #access the list of reservations for a specific date
  # def view_reservations_on(date)
  #   # list_of_res_on this date ^ above = []<--create emtpy array
  #   #@reservations.each do |reservation|
  #   #if (reservation.checkin_time..reservation.checkout_time).include?(date)
  #   #then list_of_res_on (date) << reservation
  #   #return the array  list_of_res_on (date)
  #   # end
  #

#

  #
  # private #helper methods below
  # def view_two_dates_as_range()  #<--put params {checkin_time: checkin, checkout_time: checkout}
  # def check_if_rooms_available_on(date_range)

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
